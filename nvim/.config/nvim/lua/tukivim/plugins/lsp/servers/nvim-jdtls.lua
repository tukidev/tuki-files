local jdtls = require("jdtls")
local handlers = require("tukivim.plugin-config.lsp.handlers")

--- [ VIM OPTIONS ]
local options = {
	-- shiftwidth = 2,
	-- tabstop = 2,
}

for k,v in pairs(options) do
  vim.opt_local[k] = v
end

--- [ KEYMAPS DEFINING ]
local keymaps = {
	normal_mode = {
		l = {
			name = "LSP",

			o = { jdtls.organize_imports, "Organize imports" },
			v = { jdtls.extract_variable, "Extract Variable" },
			c = { jdtls.extract_constant, "Extract Constant" },
			t = { jdtls.test_nearest_method, "Test Method" },
			T = { jdtls.test_class, "Test Class" },
		},
	},
	visual_mode = {
		l = {
			name = "LSP",

			v = {
				function()
					jdtls.extract_variable(true)
				end,
				"Extract Variable",
			},
			c = {
				function()
					jdtls.extract_constant(true)
				end,
				"Extract Constant",
			},
			m = {
				function()
					jdtls.extract_method(true)
				end,
				"Extract Method",
			},
		},
	},
}

--- [ `NVIM-JDTLS` PLUGINS ]
-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.

local home = os.getenv("HOME")

local jdtls_config = vim.fn.expand("$HOME/dev/lsp/jdtls/org.eclipse.jdt.ls.product/target/repository/config_linux")
local jdtls_jar = vim.fn.expand(
	"$HOME/dev/lsp/jdtls/org.eclipse.jdt.ls.product/target/repository/plugins/org.eclipse.equinox.launcher_*.jar"
)

local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
local root_dir = require("jdtls.setup").find_root(root_markers)
if root_dir == "" then
	return
end

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = home .. "/workspace/" .. project_name

local CONF = {}

-- 
-- This is the default if not provided, you can remove it. Or adjust as needed.
-- One dedicated LSP server & client will be started per unique root_dir
CONF.root_dir = root_dir

-- Here you can configure eclipse.jdt.ls specific settings
-- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
CONF.settings = {
	java = {
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
		codeGeneration = {
			toString = {
				template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
			},
			hashCodeEquals = {
				useJava7Objects = true,
			},
			useBlocks = true,
		},
		eclipse = {
			downloadSources = true,
		},
		configuration = {
			updateBuildConfiguration = "interactive",
		},
		maven = {
			downloadSources = true,
		},
		implementationsCodeLens = {
			enabled = true,
		},
		referencesCodeLens = {
			enabled = true,
		},
		references = {
			includeDecompiledSources = true,
		},
		format = { enabled = false },
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
CONF.init_options = {
	bundles = {
		-- java-debug
		vim.fn.glob(
			"$HOME/dev/java-debug/com.microsoft.java.debug.plugin" .. "/target/com.microsoft.java.debug.plugin-*.jar"
		),

		-- vscode-java-test
		-- vim.split(vim.fn.glob("$HOME/dev/vscode-java-test/server/*.jar"), "\n"),
	},
}

CONF.capabilities = handlers.defaults.capabilities
CONF.autostart = true

CONF.on_attach = function(client, bufnr)
	client.server_capabilities.document_formatting = false
	handlers.defaults.on_attach(client, bufnr)
	require("tukivim.com.keymaps.loader").load_keymaps_wk(keymaps, nil, bufnr)

	jdtls.setup_dap({})
	require("jdtls.setup").add_commands()

	if not vim.g.jdtls_on then
		vim.notify("Using `nvim-jdtls` plugin")
	end

	vim.g.jdtls_on = true
end

-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
require("jdtls").start_or_attach(CONF)

