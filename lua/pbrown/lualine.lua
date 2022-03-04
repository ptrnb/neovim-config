local status_ok, lualine = pcall(require, 'lualine')
if not status_ok then
  return
end

lualine.setup {
  options = {
    icons_enabled = true,
    theme = 'everforest',
    component_separators = { left = '', right = ''},
    -- section_separators = { left = '', right = ''},
    -- section_separators = { left = '', right = ''},
    section_separators = { left = '|', right = '|' },
    -- section_separators = { left = ' ', right = ' ' },
    disabled_filetypes = {"NvimTree", "toggleterm"},
    always_divide_middle = true,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch',  'diff', 'diagnostics'},
    lualine_c = {
      {
        'filename',
        path = 1,
        padding = 5,
        shorting_target = 40,
      }
    },
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    -- lualine_y = {'progress'},
    lualine_y = {},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}
