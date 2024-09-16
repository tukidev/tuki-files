local options = {
  shiftwidth = 4,
  tabstop = 4,
}

for key, value in pairs(options) do
  vim.opt_local[key] = value
end
