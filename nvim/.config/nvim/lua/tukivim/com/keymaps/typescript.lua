local ts = require("typescript")

return {
  normal_mode = {
    ["lo"] = { ts.actions.organizeImports, "Organize Imports" },
    ["lO"] = { ts.actions.addMissingImports, "Add Missing Imports" },
    ["lR"] = { "<cmd>TypescriptRenameFile<cr>", "Rename File" },
  },
}
