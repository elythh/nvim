return {
  {
    "folke/snacks.nvim",
    keys = {
      {
        "<leader>fh",
        function()
          Snacks.picker.help()
        end,
        "[F]ind [H]elp",
      },
      {
        "<leader>fk",
        function()
          Snacks.picker.keymaps()
        end,
        "[F]ind [K]eymaps",
      },
      {
        "<leader>ff",
        function()
          Snacks.picker.files()
        end,
        "[F]ind [F]iles",
      },
      {
        "<leader>fw",
        function()
          Snacks.picker.grep()
        end,
        "[F]ind [W]ords",
      },
      {
        "<leader>fd",
        function()
          Snacks.picker.diagnostics()
        end,
        "[F]ind [D]iagnostics",
      },
      {
        "<leader>fr",
        function()
          Snacks.picker.resume()
        end,
        "[F]ind [R]esume",
      },
      {
        "<leader>fi",
        function()
          Snacks.picker.icons()
        end,
        "[F]ind [I]cons",
      },
      {
        "<leader>f.",
        function()
          Snacks.picker.recent()
        end,
        '[F]ind Recent Files ("." for repeat)',
      },

      {
        "<leader>n",
        function()
          Snacks.picker.notifications()
        end,
        "[N]otification History",
      },
      {
        "<leader>fu",
        function()
          Snacks.picker.undo()
        end,
        "[U]ndo History",
      },
    },

    opts = {
      picker = {
        enabled = true,
        prompt = "  ",
        focus = "input",
        layout = {
          cycle = true,
          --- Use the default layout or vertical if the window is too narrow
          preset = function()
            return vim.o.columns >= 120 and "default" or "vertical"
          end,
        },
        matcher = {
          fuzzy = true,
        },
        ui_select = true,
      },
    },
  },
}
