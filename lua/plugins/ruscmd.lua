return {
  "aveplen/ruscmd.nvim",
  config = function()
    require("ruscmd").setup({
      abbreviations = true, -- включает сокращения вроде :й → :q
      keymaps = true, -- главное: переводит normal mode команды
    })
  end,
}
