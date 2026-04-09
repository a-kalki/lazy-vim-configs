-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

return {
  -- Настройка лидера (Space)
  {
    "folke/which-key.nvim",
    opts = {
      icons = { mappings = false },
      spec = {
        { "<leader>", group = "Editor" },
        { "<lccalleader>", group = "UI" },
      },
    },
  },

  -- Основные маппинги
  {
    "nvim-lazyvim",
    keys = {
      -- Системные и кастомные движения
      { "<leader>p", "p", desc = "Paste", mode = { "n", "v" } },
      {
        "<leader>rp",
        function()
          local path = vim.fn.expand("%:~:.")
          vim.fn.setreg('"', path)
          vim.fn.setreg("+", path)
        end,
        desc = "Copy relative path",
      },
      {
        "<leader>rc",
        function()
          local path = vim.fn.expand("%:~:.")
          vim.fn.setreg('"', path)
          vim.fn.setreg("+", path)
        end,
        desc = "Copy relative path",
      },

      -- Copy file content with path (альтернатива вашей сложной команде)
      {
        "<leader>rf",
        function()
          local path = vim.fn.expand("%:~:.")
          local content = vim.fn.join(vim.fn.readfile(vim.fn.expand("%:p")), "\n")
          local full = "-- " .. path .. "\n" .. content
          vim.fn.setreg('"', full)
          vim.fn.setreg("+", full)
        end,
        desc = "Copy file with path",
      },

      -- Комментарии
      { "gc", vim.NIL, desc = "Toggle comment", mode = { "n", "v" } },
      { "gcc", vim.NIL, desc = "Toggle comment line", mode = "n" },

      -- Folding
      {
        "zt",
        function()
          vim.cmd("foldopen")
        end,
        desc = "Toggle fold",
      },
      {
        "zff",
        function()
          vim.cmd("normal zR")
        end,
        desc = "Fold all",
      },
      {
        "zfu",
        function()
          vim.cmd("normal zM")
        end,
        desc = "Unfold all",
      },
      {
        "zfq",
        function()
          vim.cmd("set foldlevel=1")
        end,
        desc = "Fold level 1",
      },
      {
        "zfw",
        function()
          vim.cmd("set foldlevel=2")
        end,
        desc = "Fold level 2",
      },
      {
        "zfe",
        function()
          vim.cmd("set foldlevel=3")
        end,
        desc = "Fold level 3",
      },

      -- Save operations
      { "<leader>w", "<cmd>write<CR>", desc = "Save" },
      { "<leader>W", "<cmd>wa<CR>", desc = "Save all" },
      { "<leader>q", "<cmd>q<CR>", desc = "Close buffer" },
      {
        "<leader>Q",
        function()
          local bufnr = vim.api.nvim_get_current_buf()
          vim.cmd("only")
          vim.api.nvim_buf_delete(bufnr, { force = true })
        end,
        desc = "Close other buffers",
      },

      -- Navigation between splits
      { "<C-h>", "<C-w>h", desc = "Go to left pane" },
      { "<C-l>", "<C-w>l", desc = "Go to right pane" },
      { "<C-k>", "<C-w>k", desc = "Go to up pane" },
      { "<C-j>", "<C-w>j", desc = "Go to down pane" },

      -- Sneak (аналог , и shift-, в zed)
      {
        "s",
        function()
          require("flash").jump()
        end,
        desc = "Flash jump",
      },
      {
        "S",
        function()
          require("flash").jump({ backwards = true })
        end,
        desc = "Flash jump backward",
      },

      -- Surround (ваш s в visual режиме)
      { "gs", "<Plug>(nvim-surround)", desc = "Surround", mode = { "n", "v" } },

      -- Visual режим
      { "<leader>y", '"+y', desc = "Copy to system clipboard", mode = "v" },

      -- Text objects
      {
        "q",
        function()
          return vim.fn.input("Quote type (' \" ` [ { (): ") .. "i"
        end,
        desc = "Inside quotes",
        expr = true,
        mode = "o",
      },
      {
        "b",
        function()
          return vim.fn.input("Bracket type ([ { (): ") .. "i"
        end,
        desc = "Inside brackets",
        expr = true,
        mode = "o",
      },

      -- Insert mode
      {
        "<C-.>",
        function()
          vim.lsp.buf.code_action()
        end,
        desc = "Code actions",
        mode = "i",
      },
      { "<C-space>", "<C-x><C-o>", desc = "Show completions", mode = "i" },
      {
        "<C-k>",
        function()
          vim.lsp.buf.signature_help()
        end,
        desc = "Signature help",
        mode = "i",
      },

      -- Copilot/Codeium accept (замените на вашего AI ассистента)
      {
        "<C-s>",
        function()
          if vim.g.copilot then
            vim.cmd("Copilot accept")
          else
            vim.cmd("normal <C-n>")
          end
        end,
        desc = "Accept AI suggestion",
        mode = "i",
      },
      {
        "<C-w>",
        function()
          if vim.g.copilot then
            vim.cmd("Copilot accept word")
          end
        end,
        desc = "Accept next word",
        mode = "i",
      },
      {
        "<C-l>",
        function()
          if vim.g.copilot then
            vim.cmd("Copilot accept line")
          end
        end,
        desc = "Accept next line",
        mode = "i",
      },
    },
  },

  -- Space меню (Editor Leader)
  {
    "nvim-lazyvim",
    keys = {
      { "<leader><leader>", "<cmd>Telescope find_files<CR>", desc = "Find files" },
      {
        "<leader>.",
        function()
          vim.lsp.buf.code_action()
        end,
        desc = "Code actions",
      },
      { "<leader>cr", vim.lsp.buf.rename, desc = "Rename" },
      {
        "<leader>ci",
        function()
          vim.lsp.buf.code_action({ apply = true, context = { only = { "source.organizeImports" } } })
        end,
        desc = "Organize imports",
      },
      { "<leader>sc", "<cmd>Trouble symbols toggle<CR>", desc = "Toggle outline" },
      { "<leader>sp", "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>", desc = "Project symbols" },
      { "<leader>/", "<cmd>Telescope live_grep<CR>", desc = "Global search" },
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<CR>", desc = "Diagnostics" },
      { "<leader>mp", "<cmd>MarkdownPreview<CR>", desc = "Markdown preview" },
      {
        "<leader>rt",
        function()
          vim.cmd("TaskRunner")
        end,
        desc = "Run nearest task",
      },

      -- Buffer navigation
      { "<S-h>", "<cmd>bprevious<CR>", desc = "Previous buffer" },
      { "<S-l>", "<cmd>bnext<CR>", desc = "Next buffer" },

      -- LSP navigation
      { "gd", vim.lsp.buf.definition, desc = "Go to definition" },
      {
        "gD",
        function()
          vim.lsp.buf.definition({ split = "split" })
        end,
        desc = "Go to definition split",
      },
      { "gr", vim.lsp.buf.references, desc = "Find references" },
      {
        "]d",
        function()
          vim.diagnostic.goto_next()
        end,
        desc = "Next diagnostic",
      },
      {
        "[d",
        function()
          vim.diagnostic.goto_prev()
        end,
        desc = "Previous diagnostic",
      },
      { "K", vim.lsp.buf.hover, desc = "Hover" },
    },
  },

  -- Shift меню (UI Leader) - используем <localleader> который по умолчанию \
  {
    "nvim-lazyvim",
    keys = {
      { "<localleader>t", "<cmd>ToggleTerm<CR>", desc = "Toggle terminal" },
      { "<localleader>p", "<cmd>Neotree toggle<CR>", desc = "Toggle project panel" },
      { "<localleader>g", "<cmd>Neogit<CR>", desc = "Toggle git panel" },
      { "<localleader>o", "<cmd>Trouble symbols toggle<CR>", desc = "Toggle outline" },
      { "<localleader>b", "<cmd>Neotree toggle left<CR>", desc = "Toggle left dock" },
      { "<localleader>m", "<cmd>Neotree toggle right<CR>", desc = "Toggle right dock" },
      {
        "<localleader>f",
        function()
          local node = require("neo-tree.sources.manager").get_state("filesystem")
          if node and node.path then
            vim.cmd("Neotree focus filesystem reveal " .. vim.fn.expand("%:p"))
          end
        end,
        desc = "Reveal in project panel",
      },
    },
  },

  -- Project panel navigation (Neo-tree)
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      window = {
        mappings = {
          ["a"] = function(state)
            require("neo-tree.sources.filesystem").add(state)
          end,
          ["A"] = function(state)
            require("neo-tree.sources.filesystem").add_directory(state)
          end,
          ["r"] = function(state)
            require("neo-tree.sources.filesystem").rename(state)
          end,
          ["c"] = function(state)
            require("neo-tree.sources.filesystem").copy(state)
          end,
          ["p"] = function(state)
            require("neo-tree.sources.filesystem").paste(state)
          end,
          ["d"] = function(state)
            require("neo-tree.sources.filesystem").trash(state)
          end,
          ["q"] = function(state)
            require("neo-tree.ui.renderer").close_window(state)
          end,
          ["v"] = function(state)
            local node = state.tree:get_node()
            if node.type == "file" then
              vim.cmd("vsplit " .. node.path)
            end
          end,
        },
      },
    },
  },
}
