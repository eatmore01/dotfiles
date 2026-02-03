local opt = vim.opt

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")


-- keybindipgs
vim.keymap.set("n", "<C-b>", "<CMD>NvimTreeToggle<CR>", {
  desc = "Toggle NvimTree",
})

--- basic
opt.number = true

opt.clipboard = "unnamedplus" # -- share system copy buffer

opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true

opt.showtabline = 2

opt.breakindent = true
opt.linebreak = true

opt.cursorline = true
opt.scrolloff = 8

opt.mouse = "a"

opt.foldmethod = "manual"
opt.foldenable = false

opt.spell = false

opt.swapfile = false

opt.timeoutlen = 300

opt.termguicolors = true
opt.showmode = true

opt.splitbelow = true
opt.splitkeep = "screen"
opt.splitright = true

opt.cmdheight = 0

opt.fillchars = {
  eob = " ",
}
