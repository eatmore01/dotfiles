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

-- leader key space (for <leader> bindings)
vim.g.mapleader = " "

-- vim.opt.termguicolors = true

vim.opt.rtp:prepend(lazypath)
require("lazy").setup("plugins")

vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        vim.cmd("hi LineNr guifg=#7aa2f7 ctermfg=81 gui=bold")
        vim.cmd("hi CursorLineNr guifg=#7aa2f7 ctermfg=81 gui=bold,underline")
        vim.cmd("hi SignColumn guibg=NONE ctermbg=NONE")
    end,
})

-- keybindipgs
vim.keymap.set("n", "<C-b>", "<CMD>NvimTreeToggle<CR>", {
    desc = "Toggle NvimTree",
})

-- cleanr searh (Ctrl+L)
vim.keymap.set("n", "<C-L>", function()
    vim.cmd("nohlsearch")
    return "<C-L>"
end, { expr = true, desc = "Clear search highlighting" })

vim.keymap.set("n", "<A-j>", ":m .+1<CR>", { silent = true, desc = "Move line down (no reindent)" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>", { silent = true, desc = "Move line up (no reindent)" })

-- swipe with space + nub,mer
vim.keymap.set("n", "<leader>1", "<Cmd>BufferLineGoToBuffer 1<CR>", { desc = "Buffer 1" })
vim.keymap.set("n", "<leader>2", "<Cmd>BufferLineGoToBuffer 2<CR>", { desc = "Buffer 2" })
vim.keymap.set("n", "<leader>3", "<Cmd>BufferLineGoToBuffer 3<CR>", { desc = "Buffer 3" })
vim.keymap.set("n", "<leader>4", "<Cmd>BufferLineGoToBuffer 4<CR>", { desc = "Buffer 4" })
vim.keymap.set("n", "<leader>5", "<Cmd>BufferLineGoToBuffer 5<CR>", { desc = "Buffer 5" })

-- close other <leader>d
vim.keymap.set("n", "<leader>d", "<Cmd>BufferLineCloseOthers<CR>", { desc = "Close other buffers" })

-- vim.keymap.set("n", "<leader>q", "<Cmd>bd<CR>", { desc = "Close buffer" })
vim.keymap.set("n", "<leader>q", "<Cmd>Bdelete<CR>", { desc = "Close buffer (safe)" })
-- list <leader>b
vim.keymap.set("n", "<leader>b", "<Cmd>BufferLinePick<CR>", { desc = "Pick buffer" })

vim.keymap.set("n", "<leader>w", ":write<CR>")


-- disabel shift + j
vim.keymap.set("n", "J", "<Nop>", { noremap = true, silent = true })


--- basic
opt.number = true

opt.clipboard = "unnamedplus" -- share system copy buffer

opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true

opt.autoindent = true
opt.smartindent = false
opt.cindent = false

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
