if not require("tukivim.c").pde["java"] then
  return {}
end

local UTILS = require("tukivim.c.utils")

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local mason_packages = vim.fn.stdpath("data") .. "/mason/packages/"
local sys_jvm_path = "/usr/lib/jvm/"

-- This is the same as in lspconfig.server_configurations.jdtls, but avoids
-- needing to require that when this module loads.
local java_ft = { "java" }


---Callback function should be executed after `jdtls` is attached.
---Setup keymap and dap after the lsp is fully attached.
---https://github.com/mfussenegger/nvim-jdtls#nvim-dap-configuration
---https://neovim.io/doc/user/lsp.html#LspAttach
---@param args table
local JDTLS_ATTACH_CALLBACK = function(args)
  local opts = UTILS.opts("jdtls")
  local mason_registry = require("mason-registry")
  local client = vim.lsp.get_client_by_id(args.data.client_id)

  if client and client.name == "jdtls" then
    require("tukivim.c.keymaps").load("lsp-java")

    if opts.dap
        and UTILS.has("nvim-dap")
        and mason_registry.is_installed("java-debug-adapter")
    then
      -- custom init for Java debugger
      require("jdtls").setup_dap(opts.dap)
      require("jdtls.dap").setup_dap_main_class_configs()

      -- Java Test require Java debugger to work
      if opts.test and mason_registry.is_installed("java-test") then
        -- custom keymaps for Java test runner (not yet compatible with neotest)
        require("tukivim.c.keymaps").load("lsp-java-test", args.buf)
        require("tukivim.c.keymaps").del("neotest", args.buf)
      end
    end

    -- User can set additional keymaps in opts.on_attach
    if opts.on_attach then opts.on_attach(args) end
  end
end

return {
  -- Add java to treesitter.
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "java" })
    end,
  },

  -- Ensure java debugger and test packages are installed.
  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = {
      {
        "williamboman/mason.nvim",
        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          vim.list_extend(opts.ensure_installed, { "java-test", "java-debug-adapter" })
        end,
      },
    },
  },

  -- Configure nvim-lspconfig to install the server automatically via mason, but
  -- defer actually starting it to our configuration of nvim-jtdls below.
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = { ["jdtls"] = {} },                         -- make sure mason installs the server
      setup   = { ["jdtls"] = function() return true end }, -- avoid duplicate servers
    },
  },

  -- Set up nvim-jdtls to attach to java files.
  {
    "mfussenegger/nvim-jdtls",
    ft = java_ft,
    opts = function()
      local lombok_jar_path      = vim.fn.expand(mason_packages .. "jdtls/lombok.jar")
      local jdtls_config_path    = vim.fn.expand(mason_packages .. "jdtls/config_linux")
      local jdtls_jar_path       = vim.fn.expand(mason_packages .. "jdtls/plugins/org.eclipse.equinox.launcher_*.jar")
      local jdtls_workspace_path = vim.fn.stdpath("cache") .. "/jdtls/" .. project_name .. "/workspace"

      local java_dap_path        = mason_packages .. "java-debug-adapter/"
      local java_test_path       = mason_packages .. "java-test/"


      return {
        root_dir     = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }),
        settings     = {
          signatureHelp = { enabled = true },
          contentProvider = { preferred = "fernflower" },
          completion = {
            favoriteStaticMembers = {
              "org.hamcrest.MatcherAssert.assertThat",
              "org.hamcrest.Matchers.*",
              "org.hamcrest.CoreMatchers.*",
              "org.junit.jupiter.api.Assertions.*",
              "java.util.Objects.requireNonNull",
              "java.util.Objects.requireNonNullElse",
              "org.mockito.Mockito.*",
            },
            filteredTypes = {
              "com.sun.*",
              "io.micrometer.shaded.*",
              "java.awt.*",
              "jdk.*",
              "sun.*",
            },
          },
          sources = {
            organizeImports = {
              starThreshold = 9999,
              staticStarThreshold = 9999,
            },
          },
          java = {
            configuration = {
              -- Runtime switcher configuration
              runtimes = {
                { name = "JavaSE-1.8", path = sys_jvm_path .. "java-8-openjdk/" },
                { name = "JavaSE-11",  path = sys_jvm_path .. "java-11-openjdk/" },
                { name = "JavaSE-17",  path = sys_jvm_path .. "java-17-openjdk/" },
                { name = "JavaSE-20",  path = sys_jvm_path .. "java-20-openjdk/" },
              },
            },
          },
          codeGeneration = {
            toString       = { template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}" },
            hashCodeEquals = { useJava7Objects = true },
            useBlocks      = true,
          },
          eclipse = { downloadSources = true },
          configuration = { updateBuildConfiguration = "interactive" },
          maven = { downloadSources = true },
          implementationsCodeLens = { enabled = true },
          referencesCodeLens = { enabled = true },
          references = { includeDecompiledSources = true },
          inlayHints = { parameterNames = { enabled = "all" } }, -- literals, all, none
          format = { enabled = true },

        },
        cmd          = {
          --  : $PATH or '/path/to/java17_or_newer/bin/java'
          "java",

          "-Declipse.application=org.eclipse.jdt.ls.core.id1",
          "-Dosgi.bundles.defaultStartLevel=4",
          "-Declipse.product=org.eclipse.jdt.ls.core.product",
          "-Dlog.protocol=true",
          "-Dlog.level=ALL",
          "-javaagent:" .. lombok_jar_path,
          "-Xms1g",
          "--add-modules=ALL-SYSTEM",
          "--add-opens",
          "java.base/java.util=ALL-UNNAMED",
          "--add-opens",
          "java.base/java.lang=ALL-UNNAMED",

          --  : jdt.ls jar file to use
          "-jar", jdtls_jar_path,

          --  : jdt.ls server os configuration
          "-configuration", jdtls_config_path,

          --  : `data directory configuration` section in the README
          "-data", jdtls_workspace_path,
        },

        on_attach    = function(client, bufnr)
          require("tukivim.plugins.utils.lsp").on_attach(client, bufnr)
        end,

        -- How to find the project name for a given root dir.
        project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t"),


        -- These depend on nvim-dap, but can additionally be disabled by setting false here.
        dap  = { hotcodereplace = "auto", config_overrides = {} },
        test = true,
      }
    end,

    config = function(_, opts)
      -- Find the extra bundles that should be passed on the jdtls command-line
      -- if nvim-dap is enabled with java debug/test.
      local mason_registry = require("mason-registry")
      local bundles = {} ---@type string[]
      if opts.dap and UTILS.has("nvim-dap") and mason_registry.is_installed("java-debug-adapter") then
        local java_dbg_pkg = mason_registry.get_package("java-debug-adapter")
        local java_dbg_path = java_dbg_pkg:get_install_path()
        local jar_patterns = {
          java_dbg_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar",
        }

        -- java-test also depends on java-debug-adapter.
        if opts.test and mason_registry.is_installed("java-test") then
          local java_test_pkg = mason_registry.get_package("java-test")
          local java_test_path = java_test_pkg:get_install_path()
          vim.list_extend(jar_patterns, {
            java_test_path .. "/extension/server/*.jar",
          })
        end

        for _, jar_pattern in ipairs(jar_patterns) do
          for _, bundle in ipairs(vim.split(vim.fn.glob(jar_pattern), "\n")) do
            table.insert(bundles, bundle)
          end
        end
      end

      opts = vim.tbl_deep_extend("force", {
        init_options = { bundles = bundles },
        capabilities = require("cmp_nvim_lsp").default_capabilities()
      }, opts)

      -- Attach the jdtls for each java buffer. HOWEVER, this plugin loads
      -- depending on filetype, so this autocmd doesn't run for the first file.
      -- For that, we call directly below.
      vim.api.nvim_create_autocmd("FileType", {
        pattern = java_ft,
        callback = function() require("jdtls").start_or_attach(opts) end,
      })

      vim.api.nvim_create_autocmd("LspAttach", { callback = JDTLS_ATTACH_CALLBACK })

      -- Avoid race condition by calling attach the first time, since the autocmd won't fire.
      require("jdtls").start_or_attach(opts)
    end,
  },

}
