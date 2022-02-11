local status_ok, nightfox = pcall(require, 'nightfox')
if not status_ok then
  return
end

nightfox.setup(
  {
    fox = "nordfox", -- change the colorscheme to use nordfox
    styles = {
      comments = "italic", -- change style of comments to be italic
--      keywords = "bold", -- change style of keywords to be bold
--      functions = "italic,bold" -- styles can be a coggmma separated list
    },
    inverse = {
        match_paren = true, -- inverse the highlighting of match_parens
    },
    colors = {
      red = "#FF000", -- Override the red color for MAX POWER
      bg_alt = "#000000",
    },
    hlgroups = {
      TSPunctDelimiter = { fg = "${red}" }, -- Override a highlight group with the color red
      LspCodeLens = { bg = "#000000", style = "italic" },
    }
  }
)
-- Load the configuration set above and apply the colorscheme
nightfox.load()
