return {
  ["lua_ls"] = {
    settings = {
      Lua = {
        completion = { callSnippet = "Replace" },
        diagnostics = {
          disable = { "incomplete-signature-doc" },
          globals = { "vim" },
        },
        format = {
          enable = true,
          defaultConfig = {
            indent_style = "space",
            indent_size = "2",
            continuation_indent_size = "2",
          },
        },
        telemetry = { enable = false },
        runtime = { version = 'LuaJIT' },
        workspace = {
          checkThirdParty = false,
          library = { vim.env.VIMRUNTIME },
        }
      },
    }
  }
}
