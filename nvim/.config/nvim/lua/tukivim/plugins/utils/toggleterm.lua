local Terminal = require('toggleterm.terminal').Terminal


local function M()
  local self = {}
  local ind = 1

  self.lazygit = Terminal:new({
    count = 5,
    cmd = "lazygit",
    hidden = true,
    direction = "float",
    float_opts = { border = "double" },
  })

  self.lazygit_toggle = function()
    self.lazygit:toggle()
  end

  self.new_term = function()
    vim.cmd(ind .. [[ToggleTerm]])
    ind = ind + 1
  end


  return self
end

return M()
