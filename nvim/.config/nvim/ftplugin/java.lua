-- =======================================================
-- ==              NVIM LOCAL SETTINGS                  ==
-- =======================================================
--#region settings

local options = {
  shiftwidth = 4,
  tabstop = 4,
}

for key, value in pairs(options) do
  vim.opt_local[key] = value
end

--[[
local keymaps = {
  normal_mode = {
    l = {
      name = "LSP",

    },
  },
  visual_mode = {
    l = {
      name = "LSP",

    },
  },
}

--#endregion

-- =======================================================
-- ==                      PATHS                       ==
-- =======================================================
--#region PATHS

local home = os.getenv("HOME")
local mason_packages = vim.fn.stdpath("data") .. "/mason/packages/"

local java_dap = mason_packages .. "java-debug-adapter/"
local java_test = mason_packages .. "java-test/"

-- local java_dap_local = vim.fn.expand("$HOME/dev/dap/java-debug")
-- local java_test_local = vim.fn.expand("$HOME/dev/vscode-java-test")

local jdtls_path = mason_packages .. "jdtls/"
local jdtls_config = vim.fn.expand(jdtls_path .. "config_linux")
local jdtls_jar = vim.fn.expand(jdtls_path .. "plugins/org.eclipse.equinox.launcher_*.jar")

local lombok_jar = vim.fn.expand(jdtls_path .. "lombok.jar")

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = home .. "/workspace/jdtls/" .. project_name

--#endregion

-- =======================================================
-- ==               JDTLS CONFIGURATION                ==
-- =======================================================
--#region JDTLS

local jdtls = require("jdtls")
local handlers = require("tukivim.plugins.lsp.handlers")

local CONF = {}

-- 
-- This is the default if not provided, you can remove it. Or adjust as needed.
-- One dedicated LSP server & client will be started per unique root_dir
local root_markers = {
  ".git",
  "mvnw",
  "gradlew",
  "pom.xml",
  "build.gradle",
}
local root_dir = require("jdtls.setup").find_root(root_markers)

if root_dir == "" then
  return
end

CONF.root_dir = root_dir

-- Here you can configure eclipse.jdt.ls specific settings
-- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
CONF.settings = {
  java = {
    signatureHelp           = { enabled = true },
    contentProvider         = { preferred = "fernflower" },
    completion              = {
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
    sources                 = {
      organizeImports = {
        starThreshold = 9999,
        staticStarThreshold = 9999,
      },
    },
    codeGeneration          = {
      toString       = { template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}" },
      hashCodeEquals = { useJava7Objects = true },
      useBlocks      = true,
    },
    eclipse                 = { downloadSources = true },
    configuration           = { updateBuildConfiguration = "interactive" },
    maven                   = { downloadSources = true },
    implementationsCodeLens = { enabled = true },
    referencesCodeLens      = { enabled = true },
    references              = { includeDecompiledSources = true },
    inlayHints              = { parameterNames = { enabled = "all" } }, -- literals, all, none
    format                  = { enabled = true },
  },
}

-- The command that starts the language server
-- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
CONF.cmd = {

  --  : $PATH or '/path/to/java17_or_newer/bin/java'
  "java",

  "-Declipse.application=org.eclipse.jdt.ls.core.id1",
  "-Dosgi.bundles.defaultStartLevel=4",
  "-Declipse.product=org.eclipse.jdt.ls.core.product",
  "-Dlog.protocol=true",
  "-Dlog.level=ALL",
  "-javaagent:" .. lombok_jar,
  "-Xms1g",
  "--add-modules=ALL-SYSTEM",
  "--add-opens",
  "java.base/java.util=ALL-UNNAMED",
  "--add-opens",
  "java.base/java.lang=ALL-UNNAMED",

  --  : jdt.ls jar file to use
  "-jar",
  jdtls_jar,

  --  : jdt.ls server os configuration
  "-configuration",
  jdtls_config,

  --  : `data directory configuration` section in the README
  "-data",
  workspace_dir,
}

-- Extend the `bundles` with paths to jar files
-- to use additional eclipse.jdt.ls plugins.
local bundles = {}
local ext_server_path = "extension/server/"
table.insert(bundles, vim.fn.glob(java_dap .. ext_server_path .. "com.microsoft.java.debug.plugin-*.jar", 1))
vim.list_extend(bundles, vim.split(vim.fn.glob(java_test .. ext_server_path .. "*.jar", 1), "\n"))

-- local bundles = {
-- 	vim.fn.glob(java_dap_local .. "com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar", 1),
-- }
-- vim.list_extend(bundles, vim.split(vim.fn.glob(java_test_local .. "/server/*.jar", 1), "\n"))

local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

CONF['init_options'] = {
  bundles = bundles,
  extendedClientCapabilities = extendedClientCapabilities,
}

-- CONF.capabilities = handlers.defaults.capabilities
CONF.autostart = true

CONF['on_attach'] = function(client, bufnr)
  client.server_capabilities.document_formatting = false
  handlers.defaults.on_attach(client, bufnr)
  require("tukivim.com.keymaps.loader").load_keymaps_wk(keymaps, nil, bufnr)

  jdtls.setup_dap()
  require("jdtls.setup").add_commands()
end

--#endregion

-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
require("jdtls").start_or_attach(CONF)

--]]
