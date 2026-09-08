vim.opt_local.wrap = true
vim.opt_local.linebreak = true
vim.opt_local.breakindent = true
vim.opt_local.spell = true
vim.opt_local.spelllang = "en"
vim.opt_local.spellfile = vim.fn.stdpath("data") .. "/spell/en.utf-8.add"

local function display_line_motion(key)
  return function()
    return vim.v.count == 0 and "g" .. key or key
  end
end

vim.keymap.set("n", "j", display_line_motion("j"), {
  buffer = true,
  expr = true,
  desc = "Move down by display line",
})
vim.keymap.set("n", "k", display_line_motion("k"), {
  buffer = true,
  expr = true,
  desc = "Move up by display line",
})
