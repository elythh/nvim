return {
  {
    "nvim-mini/mini.hipatterns",
    version = false,
    config = function()
      local mini_hipatterns = require "mini.hipatterns"

      mini_hipatterns.setup {
        highlighters = {
          -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
          fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
          hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
          todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
          note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

          -- Highlight hex color strings (`#rrggbb`) using that color
          hex_color = mini_hipatterns.gen_highlighter.hex_color(),
        },
      }
    end,
  },
  { "nvim-mini/mini.icons" },
  {
    "nvim-mini/mini.sessions",
    config = function()
      local mini_sessions = require "mini.sessions"
      mini_sessions.setup()
    end,
  },
  {
    "nvim-mini/mini.diff",
    config = function()
      local mini_diff = require "mini.diff"
      mini_diff.setup()
    end,
  },
  {
    "nvim-mini/mini.starter",
    config = function()
      local mini_starter = require "mini.starter"

      mini_starter.setup {
        evaluate_single = true,
        header = "hello",
        footer = "",
        content_hooks = {
          mini_starter.gen_hook.aligning("center", "center"),
        },
        items = {
          mini_starter.sections.builtin_actions(),
          mini_starter.sections.recent_files(5, true, false),
        },
      }
    end,
    version = false,
  },
  {
    "nvim-mini/mini.ai",
    config = function()
      local mini_ai = require "mini.ai"

      mini_ai.setup { n_lines = 500 }
    end,
    version = false,
  },
  {
    "nvim-mini/mini.pairs",
    events = { "BufEnter" },
    config = function()
      local mini_pairs = require "mini.pairs"

      mini_pairs.setup {}
    end,
    version = false,
  },
  {
    "nvim-mini/mini.clue",
    events = { "BufEnter" },
    event = "VeryLazy",
    config = function()
      local mini_clue = require "mini.clue"

      mini_clue.setup {
        window = {
          delay = 500,
          config = {
            border = "none",
            width = math.floor(0.318 * vim.o.columns),
            row = "auto",
            col = "auto",
            anchor = "NE",
          },
        },
        triggers = {
          { mode = "n", keys = "<leader>" },
          { mode = "x", keys = "<leader>" },
          { mode = "i", keys = "<C-x>" },
          { mode = "n", keys = "g" },
          { mode = "x", keys = "g" },
          { mode = "n", keys = "'" },
          { mode = "n", keys = "`" },
          { mode = "n", keys = "]" },
          { mode = "n", keys = "[" },
          { mode = "x", keys = "'" },
          { mode = "x", keys = "`" },
          { mode = "n", keys = '"' },
          { mode = "x", keys = '"' },
          { mode = "i", keys = "<C-r>" },
          { mode = "c", keys = "<C-r>" },
          { mode = "n", keys = "<C-w>" },
          { mode = "n", keys = "z" },
          { mode = "x", keys = "z" },
        },
        clues = {
          require("mini.clue").gen_clues.builtin_completion(),
          require("mini.clue").gen_clues.g(),
          require("mini.clue").gen_clues.marks(),
          require("mini.clue").gen_clues.registers(),
          require("mini.clue").gen_clues.windows(),
          require("mini.clue").gen_clues.z(),
          { mode = "n", keys = "<Leader>b", desc = "+Buffer" },
          { mode = "n", keys = "<Leader>f", desc = "+Find" },
          { mode = "n", keys = "<Leader>g", desc = "+Git" },
          { mode = "n", keys = "<Leader>l", desc = "+Language" },
          { mode = "n", keys = "<Leader>m", desc = "+Map" },
          { mode = "n", keys = "<Leader>a", desc = "+Sidekick" },
          { mode = "n", keys = "<Leader>c", desc = "+CodeAction" },
          { mode = "n", keys = "<Leader>l", desc = "+Language" },
          { mode = "n", keys = "<Leader>s", desc = "+Sessions" },
        },
      }
    end,
    version = false,
  },
  {
    "nvim-mini/mini.visits",
    config = function()
      require("mini.visits").setup()
    end,
  },
  {
    "nvim-mini/mini.extra",
    config = function()
      require("mini.extra").setup()
    end,
  },
}
