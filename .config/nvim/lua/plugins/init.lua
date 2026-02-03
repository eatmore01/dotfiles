return {
  {
    "nvim-tree/nvim-tree.lua",
    lazy = false, -- load on startup
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        auto_reload_on_write = true,
        open_on_setup_file = true,
        view = {
          width = 30,
        },
      })
    end,
  },
}
