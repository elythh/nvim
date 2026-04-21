return {
  {
    "folke/tokyonight.nvim",
    config = function()
      require("tokyonight").setup {
        transparent = true,
        on_highlights = function(hl, c)
          local function set_transparent(group)
            local existing = hl[group]
            if type(existing) == "table" then
              hl[group] = vim.tbl_extend("force", existing, { bg = c.none })
            else
              hl[group] = { bg = c.none }
            end
          end

          hl.TabLineFill = {
            bg = c.none,
          }
          set_transparent "TabLineSel"
          set_transparent "BufferLineFill"
          set_transparent "BufferLineBackground"
          set_transparent "BufferLineBuffer"
          set_transparent "BufferLineBufferVisible"
          set_transparent "BufferLineBufferSelected"
          set_transparent "BufferLineCloseButton"
          set_transparent "BufferLineCloseButtonVisible"
          set_transparent "BufferLineCloseButtonSelected"
          set_transparent "BufferLineModified"
          set_transparent "BufferLineModifiedVisible"
          set_transparent "BufferLineModifiedSelected"
          set_transparent "BufferLineSeparator"
          set_transparent "BufferLineSeparatorVisible"
          set_transparent "BufferLineSeparatorSelected"
          set_transparent "BufferLineDiagnostic"
          set_transparent "BufferLineDiagnosticVisible"
          set_transparent "BufferLineDiagnosticSelected"
          hl.BlinkCmpMenu = {
            bg = c.bg_dark,
          }
          hl.BlinkCmpMenuSelection = {
            bg = c.bg_highlight,
          }
          hl.BlinkCmpDoc = {
            bg = c.bg_dark,
          }
          hl.BlinkCmpMenuBorder = {
            bg = c.bg_dark,
            fg = c.bg_dark,
          }
          hl.BlinkCmpdocBorder = {
            bg = c.bg_dark,
            fg = c.bg_dark,
          }
        end,
        on_colors = function(colors)
          colors.bg_statusline = colors.none
        end,
        styles = {
          sidebars = "transparent", -- style for sidebars, see below
          floats = "transparent", -- style for floating windows
        },
      }

      vim.cmd.colorscheme "tokyonight-moon"
    end,
  },
}
