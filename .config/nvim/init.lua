vim.g.mapleader = " "
require "config.variables"
require "options"
vim.cmd "source $HOME/.config/nvim/vim/abbrev.vim"

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  "folke/neodev.nvim",
  "nvim-lua/popup.nvim",
  "nvim-lua/plenary.nvim",
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      {
        "<leader>w",
        function()
          require("telescope").extensions.git_worktree.git_worktrees()
        end,
        desc = "Git Worktrees",
      },
      {
        "<leader>W",
        function()
          require("telescope").extensions.git_worktree.create_git_worktree()
        end,
        desc = "Git Worktrees",
      },
    },
  },
  {
    "stevearc/oil.nvim",
    opts = {
      view_options = {
        show_hidden = true,
      },
      keymaps = {
        ["g?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["<C-s>"] = {
          "actions.select",
          opts = { vertical = true },
          desc = "Open the entry in a vertical split",
        },
        ["<C-v>"] = {
          "actions.select",
          opts = { vertical = true },
          desc = "Open the entry in a vertical split",
        },
        ["<C-h>"] = {
          "actions.select",
          opts = { horizontal = true },
          desc = "Open the entry in a horizontal split",
        },
        ["<C-t>"] = {
          "actions.select",
          opts = { tab = true },
          desc = "Open the entry in new tab",
        },
        ["<C-p>"] = "actions.preview",
        ["<C-c>"] = "actions.close",
        ["<C-x>"] = "actions.close",
        ["<C-l>"] = "actions.refresh",
        ["-"] = "actions.parent",
        ["_"] = "actions.open_cwd",
        ["`"] = "actions.cd",
        ["~"] = {
          "actions.cd",
          opts = { scope = "tab" },
          desc = ":tcd to the current oil directory",
        },
        ["gs"] = "actions.change_sort",
        ["gx"] = "actions.open_external",
        ["g."] = "actions.toggle_hidden",
        ["g\\"] = "actions.toggle_trash",
      },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  {
    "stevearc/stickybuf.nvim",
    opts = {},
    config = function()
      require("stickybuf").setup()
    end,
  },
  {
    "supermaven-inc/supermaven-nvim",
    config = function()
      require("supermaven-nvim").setup {
        keymaps = {
          accept_suggestion = "<C-i>",
          accept_word = "<C-n>",
          clear_suggestion = "<C-x>",
        },
        ignore_filetypes = { sh = true },
      }
    end,
  },
  -- {
  --   'barrett-ruth/import-cost.nvim',
  --   build = 'sh install.sh bun',
  --   config = true
  -- },
  {
    "mikesmithgh/kitty-scrollback.nvim",
    enabled = true,
    lazy = true,
    cmd = { "KittyScrollbackGenerateKittens", "KittyScrollbackCheckHealth" },
    event = { "User KittyScrollbackLaunch" },
    -- version = '*', -- latest stable version, may have breaking changes if major version changed
    -- version = '^3.0.0', -- pin major version, include fixes and features that do not have breaking changes
    config = function()
      require("kitty-scrollback").setup()
    end,
  },
  "Marskey/telescope-sg",
  "nvim-telescope/telescope-ui-select.nvim",
  "kyazdani42/nvim-web-devicons",
  {
    "b0o/incline.nvim",
    opts = {
      hide = {
        focused_win = true,
      },
    },
  },
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup {
        detection_methods = { "pattern", "lsp" },
        patterns = { ".git" },
      }
    end,
  },
  { "ThePrimeagen/refactoring.nvim", opts = {} },
  "ThePrimeagen/git-worktree.nvim",
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      local harpoon = require "harpoon"
      harpoon:setup()
      local conf = require("telescope.config").values
      local function toggle_telescope(harpoon_files)
        local file_paths = {}
        for _, item in ipairs(harpoon_files.items) do
          table.insert(file_paths, item.value)
        end

        require("telescope.pickers")
          .new({}, {
            prompt_title = "Harpoon",
            finder = require("telescope.finders").new_table {
              results = file_paths,
            },
            previewer = conf.file_previewer {},
            sorter = conf.generic_sorter {},
          })
          :find()
      end

      vim.keymap.set("n", "<leader>h", function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, { desc = "Open harpoon window" })

      vim.keymap.set("n", "<leader>ga", function()
        harpoon:list():append()
      end)
      -- vim.keymap.set("n", "<leader>h", function()
      --   harpoon.ui:toggle_quick_menu(harpoon:list())
      -- end)

      vim.keymap.set("n", "<leader>1", function()
        harpoon:list():select(1)
      end)
      vim.keymap.set("n", "<leader>2", function()
        harpoon:list():select(2)
      end)
      vim.keymap.set("n", "<leader>3", function()
        harpoon:list():select(3)
      end)
      vim.keymap.set("n", "<leader>4", function()
        harpoon:list():select(4)
      end)
      vim.keymap.set("n", "<leader>5", function()
        harpoon:list():select(5)
      end)
      vim.keymap.set("n", "<leader>6", function()
        harpoon:list():select(6)
      end)
    end,
  },
  {
    "echasnovski/mini.diff",
    version = false,
    config = function()
      require("mini.diff").setup {}
      vim.keymap.set("n", "<leader>z", function()
        vim.cmd "lua MiniDiff.toggle_overlay()"
      end)
    end,
  },
  {
    "olimorris/codecompanion.nvim",
    opts = {
      adapters = {
        opts = {
          show_model_choices = true, -- <<< ADDED THIS
        },
        gemini = function()
          return require("codecompanion.adapters").extend("gemini", {
            env = {
              api_key = "AIzaSyCPgQv7ZQxeS1e_yn7IgGh-zRFLA4LnzfY",
            },
          })
        end,
        geminipro = function()
          return require("codecompanion.adapters").extend("gemini", {
            env = {
              api_key = "AIzaSyCBcJYImznJ_WWHJSXTeom5uo4rtoUyymM",
            },
            schema = {
              model = {
                default = "gemini-2.5-pro-preview-05-06",
              },
            },
          })
        end,
      },
      strategies = {
        chat = {
          adapter = "gemini",
          keymaps = {
            close = {
              modes = {
                n = "<C-x>",
                i = "<C-x>",
              },
            },
          },
        },
        inline = {
          adapter = "gemini",
        },
      },
      display = {
        diff = {
          enabled = true,
          provider = "mini_diff",
        },
      },
      extensions = {
        mcphub = {
          callback = "mcphub.extensions.codecompanion",
          opts = {
            show_result_in_chat = true, -- Show mcp tool results in chat
            make_vars = true, -- Convert resources to #variables
            make_slash_commands = true, -- Add prompts as /slash commands
          },
        },
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  },
  {
    "ravitemer/mcphub.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    build = "npm install -g mcp-hub@latest", -- Installs `mcp-hub` node binary globally
    config = function()
      require("mcphub").setup()
    end,
  },
  { "echasnovski/mini.bracketed", version = false },
  {
    "echasnovski/mini.ai",
    version = false,
    config = function()
      require("mini.ai").setup {}
    end,
  },
  -- "wellle/targets.vim",
  -- {
  --   "folke/which-key.nvim",
  --   opts = {
  --     plugins = {
  --       presets = {
  --         operators = false,
  --         motions = false,
  --         text_objects = false,
  --         windows = true,
  --         nav = true,
  --         z = true,
  --         g = true,
  --       },
  --     },
  --     win = {
  --       border = "single",
  --     },
  --   },
  -- },
  "b0o/schemastore.nvim",
  "nvim-lualine/lualine.nvim",
  "nvim-tree/nvim-tree.lua",
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      indent = {
        char = "▏",
      },
    },
  },
  "tpope/vim-fugitive",
  "tpope/vim-repeat",
  "tpope/vim-sleuth",
  "andymass/vim-matchup",
  "mfussenegger/nvim-dap",
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "<leader>t",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "<leader>T",
        mode = { "n", "o", "x" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
      {
        "r",
        mode = "o",
        function()
          require("flash").remote()
        end,
        desc = "Remote Flash",
      },
      {
        "R",
        mode = { "o", "x" },
        function()
          require("flash").treesitter_search()
        end,
        desc = "Treesitter Search",
      },
      {
        "<c-s>",
        mode = { "c" },
        function()
          require("flash").toggle()
        end,
        desc = "Toggle Flash Search",
      },
    },
  },
  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
  },
  {
    "mhinz/vim-grepper",
    cmd = { "Grepper", "GrepperRg", "GrepperAg", "GrepperGrep" },
    keys = "<plug>(GrepperOperator)",
    lazy = false,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "nvimtools/none-ls.nvim",
        dependencies = {
          "nvimtools/none-ls-extras.nvim",
        },
      },
      -- "hrsh7th/cmp-nvim-lsp",
      -- {
      --   "pmizio/typescript-tools.nvim",
      --   dependencies = { "nvim-lua/plenary.nvim" },
      --   config = function()
      --     require("typescript-tools").setup {}
      --   end,
      -- },
    },
  },
  -- {
  --   "numToStr/Comment.nvim",
  --   dependencies = {
  --     "nvim-treesitter/nvim-treesitter",
  --     "JoosepAlviste/nvim-ts-context-commentstring",
  --   },
  --   config = function()
  --     local prehook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()
  --     require"Comment".setup({
  --       pre_hook = prehook,
  --       post_hook = nil,
  --     })
  --   end,
  --   keys = { "gcc", "gc", "gb", "gbc" },
  --   lazy = false,
  --   event = "BufReadPre",
  --
  -- },
  -- {
  --   "JoosepAlviste/nvim-ts-context-commentstring",
  --   opts = {
  --     enable_autocmd = false,
  --   },
  -- },
  {
    "folke/ts-comments.nvim",
    opts = {},
    event = "VeryLazy",
    enabled = vim.fn.has "nvim-0.10.0" == 1,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },
  {
    "j-hui/fidget.nvim",
    opts = {
      progress = {
        display = {
          done_icon = " ",
        },
      },
    },
  },
  {
    "gbprod/substitute.nvim",
    keys = {
      {
        "<leader>p",
        function()
          require("substitute").operator()
        end,
        mode = "n",
        desc = "Paste in",
      },
      {
        "<leader>pp",
        function()
          require("substitute").line()
        end,
        mode = "n",
        desc = "Substitute Line",
      },
      {
        "<leader>s",
        function()
          require("substitute.range").operator()
        end,
        mode = "n",
        desc = "Substitute in Range",
      },
      {
        "<leader>s",
        function()
          require("substitute.range").visual()
        end,
        mode = "x",
        desc = "Substitute in Range",
      },
      {
        "<leader>ss",
        function()
          require("substitute.range").word()
        end,
        mode = "n",
        desc = "Substitute Curr. Word in Range",
      },
      {
        "<leader>sx",
        "<cmd>lua require('substitute.exchange').operator()<cr>",
        mode = "n",
        desc = "Substitute Exchange",
      },
      {
        "<leader>sxx",
        "<cmd>lua require('substitute.exchange').line()<cr>",
        mode = "n",
        desc = "Substitute Exchange",
      },
      {
        "<leader>X",
        "<cmd>lua require('substitute.exchange').visual()<cr>",
        mode = "x",
        desc = "Substitute Exchange",
      },
      {
        "<leader>sxc",
        "<cmd>lua require('substitute.exchange').cancel()<cr>",
        mode = "n",
        desc = "Substitute Exchange",
      },
    },
    config = function()
      require("substitute").setup {}
    end,
  },
  {
    "tpope/vim-eunuch",
    cmd = {
      "Remove",
      "Delete",
      "Move",
      "Chmod",
      "Rename",
      "Copy",
      "Duplicate",
      "Mkdir",
      "Cfind",
      "Clocate",
      "Lfind",
      "Llocate",
      "Wall",
      "SudoWrite",
      "SudoEdit",
    },
  },
  {
    "tpope/vim-obsession",
    cmd = { "Obsession", "Obsess" },
  },
  {
    "tpope/vim-characterize",
    keys = { "ga" },
  },
  {
    "tpope/vim-abolish",
    cmd = { "Abolish", "Subvert" },
  },
  {
    "junegunn/gv.vim",
    cmd = { "GV" },
  },
  -- {
  --   "folke/zen-mode.nvim",
  --   dependencies = {
  --     {
  --       "folke/twilight.nvim",
  --     },
  --   },
  --   cmd = { "ZenMode" },
  -- },
  {
    "preservim/vim-pencil",
    cmd = {
      "Pencil",
      "TogglePencil",
      "PencilSoft",
      "PencilHard",
      "HardPencil",
      "SoftPencil",
    },
  },
  {
    "Wansmer/treesj",
    keys = { "gJ", "gS" },
    dependencies = { "nvim-treesitter" },
    config = function()
      require("treesj").setup {}
      vim.keymap.set("n", "gJ", require("treesj").join, { desc = "Join lines" })
      vim.keymap.set(
        "n",
        "gS",
        require("treesj").split,
        { desc = "Split lines" }
      )
    end,
  },
  {
    "chrisbra/NrrwRgn",
    cmd = { "NarrowRegion", "NarrowWindow" },
  },
  {
    "godlygeek/tabular",
    cmd = { "Tabularize" },
  },
  {
    "vuki656/package-info.nvim",
  },
  {
    "saecki/crates.nvim",
    ft = "toml",
    config = function()
      require("crates").setup()
    end,
  },
  {
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup()
    end,
  },
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
  },
  {
    "sQVe/sort.nvim",
    cmd = "Sort",
    config = function()
      require("sort").setup {}
    end,
  },
  {
    "nacro90/numb.nvim",
    event = "CmdlineEnter",
    config = 'require("numb").setup()',
  },
  {
    "booperlv/nvim-gomove",
    keys = {
      { "<A-h>", "<Plug>GoVSMLeft", mode = "v" },
      { "<A-j>", "<Plug>GoVSMDown", mode = "v" },
      { "<A-k>", "<Plug>GoVSMUp", mode = "v" },
      { "<A-l>", "<Plug>GoVSMRight", mode = "v" },
      { "<A-h>", "<Plug>GoNSMLeft" },
      { "<A-j>", "<Plug>GoNSMDown" },
      { "<A-k>", "<Plug>GoNSMUp" },
      { "<A-l>", "<Plug>GoNSMRight" },
    },
  },
  {
    "nyngwang/NeoZoom.lua",
    branch = "neo-zoom-original",
    cmd = { "NeoZoomToggle" },
  },
  -- {
  --   "nvzone/floaterm",
  --   dependencies = "nvzone/volt",
  --   opts = {
  --     terminals = {
  --       { name = "Terminal", cmd = "fish" },
  --     },
  --   },
  --   cmd = "FloatermToggle",
  -- },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup {
        shell = "/usr/bin/fish",
        autochdir = true,
        size = 20,
      }
    end,
  },
  {
    "saghen/blink.cmp",
    dependencies = { "rafamadriz/friendly-snippets" },
    -- version = '1.*',
    build = "cargo build --release",
    opts = {
      -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
      -- 'super-tab' for mappings similar to vscode (tab to accept)
      -- 'enter' for enter to accept
      -- 'none' for no mappings
      --
      -- All presets have the following mappings:
      -- C-space: Open menu or open docs if already open
      -- C-n/C-p or Up/Down: Select next/previous item
      -- C-e: Hide menu
      -- C-k: Toggle signature help (if signature.enabled = true)
      --
      -- See :h blink-cmp-config-keymap for defining your own keymap
      cmdline = {
        keymap = {
          ["<C-j>"] = { "select_next", "fallback" },
          ["<C-k>"] = { "select_prev", "fallback" },
          ["<C-x>"] = { "hide", "fallback" },
          ["<C-l>"] = { "select_accept_and_enter", "fallback" },
          ["<C-e>"] = { "accept", "fallback" },
          ["<down>"] = { "select_next", "fallback" },
          ["<up>"] = { "select_prev", "fallback" },
        },
        completion = {
          list = {
            selection = {
              preselect = true,
              auto_insert = true,
            },
          },
          menu = {
            auto_show = true,
          },
        },
      },
      keymap = {
        preset = "default",
        ["<C-x>"] = { "hide", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-l>"] = { "select_and_accept", "fallback" },
        ["<C-e>"] = {},
        ["<C-n>"] = {},
        ["<C-p>"] = {},
      },

      appearance = {
        nerd_font_variant = "mono",
      },
      accept = { auto_brackets = { enabled = true } },
      completion = {
        documentation = { auto_show = true, auto_show_delay_ms = 500 },
      },

      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },

      fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    opts_extend = { "sources.default" },
  },
  {
    "epwalsh/obsidian.nvim",
    lazy = true,
    event = {
      "BufReadPre " .. vim.fn.expand "~" .. "/Documents/second_brain/**.md",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- "hrsh7th/nvim-cmp",
      "nvim-telescope/telescope.nvim",
      "godlygeek/tabular",
      "preservim/vim-markdown",
    },
    opts = {
      dir = "~/Documents/second_brain",
      templates = {
        subdir = "templates",
        date_format = "%Y-%m-%d",
        time_format = "%H:%M",
      },
      disable_frontmatter = true,
      note_id_func = function(title)
        if title ~= nil then
          return title:lower()
        end
        local suffix = ""
        for _ = 1, 4 do
          suffix = suffix .. string.char(math.random(65, 90))
        end
        return tostring(os.time()) .. "-" .. suffix
      end,
    },
    config = function(_, opts)
      require("obsidian").setup(opts)

      -- Optional, override the 'gf' keymap to utilize Obsidian's search functionality.
      -- see also: 'follow_url_func' config option below.
      vim.keymap.set("n", "gf", function()
        if require("obsidian").util.cursor_on_markdown_link() then
          return "<cmd>ObsidianFollowLink<CR>"
        else
          return "gf"
        end
      end, { noremap = false, expr = true })
    end,
  },
  -- {
  --   "hrsh7th/nvim-cmp",
  --   event = { "InsertEnter", "CmdlineEnter" },
  --   dependencies = {
  --     "L3MON4D3/LuaSnip",
  --     "saadparwaiz1/cmp_luasnip",
  --     "onsails/lspkind-nvim",
  --     {
  --       'altermo/ultimate-autopair.nvim',
  --       event={'InsertEnter','CmdlineEnter'},
  --       branch='v0.6', --recommended as each new version will have breaking changes
  --       opts={
  --           --Config goes here
  --       },
  --     },
  --     "jcha0713/cmp-tw2css",
  --     "hrsh7th/cmp-path",
  --     "hrsh7th/cmp-cmdline",
  --     "hrsh7th/cmp-buffer",
  --     {
  --       "hrsh7th/cmp-nvim-lua",
  --       ft = "lua",
  --     },
  --     "hrsh7th/cmp-nvim-lsp",
  --     "hrsh7th/cmp-nvim-lsp-signature-help",
  --     "lukas-reineke/cmp-rg",
  --     {
  --       "petertriho/cmp-git",
  --       ft = "gitcommit",
  --       config = function()
  --         require("cmp_git").setup()
  --       end,
  --     },
  --     -- {
  --     --   "zbirenbaum/copilot.lua",
  --     --   cmd = "Copilot",
  --     --   event = "InsertEnter",
  --     --   config = function()
  --     --     require("copilot").setup {
  --     --       filetypes = {
  --     --         markdown = true,
  --     --         sh = function()
  --     --           if
  --     --             string.match(
  --     --               vim.fs.basename(vim.api.nvim_buf_get_name(0)),
  --     --               "^%.env.*"
  --     --             )
  --     --           then
  --     --             return false
  --     --           end
  --     --           return true
  --     --         end,
  --     --       },
  --     --       suggestion = {
  --     --         enabled = true,
  --     --         auto_trigger = true,
  --     --         debounce = 75,
  --     --         keymap = {
  --     --           accept = "<M-l>",
  --     --           accept_word = "<C-n>",
  --     --           accept_line = "<C-e>",
  --     --           next = "<M-]>",
  --     --           prev = "<M-[>",
  --     --           dismiss = "<C-]>",
  --     --         },
  --     --       },
  --     --     }
  --     --   end,
  --     -- },
  --   },
  --   config = function()
  --     local luasnip = require "luasnip"
  --
  --     luasnip.config.setup {
  --       update_events = "TextChanged,TextChangedI",
  --       region_check_events = "InsertEnter",
  --     }
  --
  --     require("luasnip.loaders.from_lua").lazy_load {
  --       paths = "~/Documents/snippets/",
  --     }
  --
  --     local utils = require "utils"
  --     local t = utils.t
  --     local lspkind = require "lspkind"
  --     local cmp = require "cmp"
  --
  --     cmp.setup {
  --       snippet = {
  --         expand = function(args)
  --           luasnip.lsp_expand(args.body)
  --         end,
  --       },
  --       formatting = {
  --         format = lspkind.cmp_format(),
  --       },
  --       sources = cmp.config.sources({
  --         { name = "nvim_lsp_signature_help" },
  --         { name = "nvim_lsp" },
  --         { name = "luasnip" },
  --       }, {
  --         { name = "buffer" },
  --         { name = "path" },
  --       }, {
  --         { name = "rg" },
  --       }),
  --       mapping = {
  --         ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
  --         ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
  --         ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
  --         ["<C-x>"] = cmp.mapping {
  --           c = cmp.mapping.close(),
  --           i = function(fallback)
  --             if cmp.visible() then
  --               cmp.close()
  --               -- elseif require("copilot.suggestion").is_visible() then
  --               --   require("copilot.suggestion").dismiss()
  --             else
  --               fallback()
  --             end
  --           end,
  --         },
  --         ["<C-j>"] = cmp.mapping {
  --           c = cmp.mapping.select_next_item {
  --             behavior = cmp.SelectBehavior.Insert,
  --           },
  --           i = function(fallback)
  --             if cmp.visible() then
  --               cmp.select_next_item { behavior = cmp.SelectBehavior.Insert }
  --               -- elseif require("copilot.suggestion").is_visible() then
  --               --   require("copilot.suggestion").accept()
  --             else
  --               fallback()
  --             end
  --           end,
  --         },
  --         ["<C-k>"] = cmp.mapping(
  --           cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
  --           { "i", "c" }
  --         ),
  --         ["<S-Tab>"] = cmp.mapping(function(fallback)
  --           if cmp.visible() then
  --             cmp.select_prev_item()
  --           elseif luasnip.locally_jumpable(-1) then
  --             luasnip.jump(-1)
  --           else
  --             fallback()
  --           end
  --         end, { "i", "s" }),
  --         ["<Tab>"] = cmp.mapping(function(fallback)
  --           if cmp.visible() then
  --             cmp.select_next_item()
  --           elseif luasnip.expand_or_locally_jumpable() then
  --             luasnip.expand_or_jump()
  --           else
  --             fallback()
  --           end
  --         end, { "i", "s" }),
  --         ["<C-l>"] = cmp.mapping {
  --           i = function(fallback)
  --             if cmp.visible() then
  --               cmp.confirm {
  --                 behavior = cmp.ConfirmBehavior.Replace,
  --                 select = true,
  --               }
  --               -- elseif require("copilot.suggestion").is_visible() then
  --               --   require("copilot.suggestion").accept_line()
  --             else
  --               fallback()
  --             end
  --           end,
  --           c = function(fallback)
  --             if cmp.visible() then
  --               cmp.confirm({
  --                 behavior = cmp.ConfirmBehavior.Replace,
  --                 select = true,
  --               }, function()
  --                 return vim.api.nvim_feedkeys(t "<CR>", "c", true)
  --               end)
  --             else
  --               fallback()
  --             end
  --           end,
  --         },
  --         ["<CR>"] = cmp.mapping.confirm {
  --           behavior = cmp.ConfirmBehavior.Replace,
  --           select = true,
  --         },
  --       },
  --       window = {
  --         completion = cmp.config.window.bordered {
  --           winhighlight = "FloatBorder:FloatBorder",
  --         },
  --         documentation = cmp.config.window.bordered {
  --           winhighlight = "FloatBorder:FloatBorder",
  --         },
  --       },
  --     }
  --
  --     cmp.setup.filetype("lua", {
  --       sources = cmp.config.sources({
  --         { name = "nvim_lsp_signature_help" },
  --         { name = "nvim_lsp" },
  --         { name = "luasnip" },
  --       }, {
  --         { name = "nvim_lua" },
  --         { name = "buffer" },
  --         { name = "path" },
  --       }, {
  --         { name = "rg" },
  --       }),
  --     })
  --
  --     require("cmp-tw2css").setup()
  --
  --     cmp.setup.filetype({ "css", "scss", "less", "sass" }, {
  --       sources = cmp.config.sources({
  --         { name = "nvim_lsp_signature_help" },
  --         { name = "nvim_lsp" },
  --         { name = "luasnip" },
  --       }, {
  --         { name = "cmp-tw2css" },
  --         { name = "buffer" },
  --         { name = "path" },
  --       }, {
  --         { name = "rg" },
  --       }),
  --     })
  --
  --     cmp.setup.filetype("gitcommit", {
  --       sources = cmp.config.sources({
  --         { name = "git" },
  --       }, {
  --         { name = "nvim_lsp" },
  --         { name = "buffer" },
  --       }),
  --     })
  --
  --     cmp.setup.cmdline("?", {
  --       mapping = cmp.mapping.preset.cmdline(),
  --       sources = {
  --         { name = "buffer" },
  --       },
  --     })
  --     cmp.setup.cmdline("/", {
  --       mapping = cmp.mapping.preset.cmdline(),
  --       sources = {
  --         { name = "buffer" },
  --       },
  --     })
  --     cmp.setup.cmdline(":", {
  --       mapping = cmp.mapping.preset.cmdline(),
  --       sources = cmp.config.sources({
  --         { name = "path" },
  --       }, {
  --         {
  --           name = "cmdline",
  --           option = {
  --             ignore_cmds = { "Man", "!" },
  --           },
  --         },
  --       }),
  --     })
  --     --
  --     -- cmp.event:on("menu_opened", function()
  --     --   vim.b.copilot_suggestion_hidden = true
  --     -- end)
  --     --
  --     -- cmp.event:on("menu_closed", function()
  --     --   vim.b.copilot_suggestion_hidden = false
  --     -- end)
  --     --
  --     -- local npairs = require "nvim-autopairs"
  --     -- local cmp_autopairs = require "nvim-autopairs.completion.cmp"
  --     --
  --     -- npairs.setup {
  --     --   check_ts = true,
  --     --   break_undo = false,
  --     --   enable_abbr = true,
  --     -- }
  --     --
  --     -- cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
  --     --
  --     -- local Rule = require "nvim-autopairs.rule"
  --     -- local cond = require "nvim-autopairs.conds"
  --     --
  --     -- npairs.add_rules {
  --     --   Rule(" ", " ")
  --     --     :with_pair(cond.done())
  --     --     :replace_endpair(function(opts)
  --     --       local pair = opts.line:sub(opts.col - 1, opts.col)
  --     --       if vim.tbl_contains({ "()", "{}", "[]" }, pair) then
  --     --         return " " -- it return space here
  --     --       end
  --     --       return "" -- return empty
  --     --     end)
  --     --     :with_move(cond.none())
  --     --     :with_cr(cond.none())
  --     --     :with_del(function(opts)
  --     --       local col = vim.api.nvim_win_get_cursor(0)[2]
  --     --       local context = opts.line:sub(col - 1, col + 2)
  --     --       return vim.tbl_contains({ "(  )", "{  }", "[  ]" }, context)
  --     --     end),
  --     -- }
  --   end,
  -- },
  {
    "michaelb/sniprun",
    build = "bash ./install.sh",
    cmd = {
      "SnipRun",
      "SnipInfo",
      "SnipClose",
      "SnipReset",
      "SnipTerminate",
      "SnipReplMemoryClean",
    },
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      local npairs = require "nvim-autopairs"
      npairs.setup {
        check_ts = true,
        break_undo = false,
        enable_abbr = true,
        map_cr = true,
      }

      local Rule = require "nvim-autopairs.rule"
      local cond = require "nvim-autopairs.conds"

      npairs.add_rules {
        Rule(" ", " ")
          :with_pair(cond.done())
          :replace_endpair(function(opts)
            local pair = opts.line:sub(opts.col - 1, opts.col)
            if vim.tbl_contains({ "()", "{}", "[]" }, pair) then
              return " " -- it return space here
            end
            return "" -- return empty
          end)
          :with_move(cond.none())
          :with_cr(cond.none())
          :with_del(function(opts)
            local col = vim.api.nvim_win_get_cursor(0)[2]
            local context = opts.line:sub(col - 1, col + 2)
            return vim.tbl_contains({ "(  )", "{  }", "[  ]" }, context)
          end),
      }
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    setup = function()
      require("nvim-ts-autotag").setup {
        opts = {
          enable_close = true,
          enable_rename = true,
          enable_close_on_slash = false,
        },
      }
    end,
  },
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },
  {
    "jghauser/follow-md-links.nvim",
    ft = "markdown",
    enabled = false,
  },
  {
    "lewis6991/gitsigns.nvim",
    -- event = "BufRead",
    config = function()
      require("gitsigns").setup {
        signs = {
          add = {
            text = "▎",
          },
          change = {
            text = "▎",
          },
          delete = {
            text = "契",
          },
          topdelete = {
            text = "契",
          },
          changedelete = {
            text = "▎",
          },
          untracked = {
            text = "▎",
          },
        },
        on_attach = function(bufnr)
          local gs = require "gitsigns"

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          map("n", "<leader>hn", function()
            if vim.wo.diff then
              vim.cmd.normal { "<leader>hn", bang = true }
            else
              gs.nav_hunk "next"
            end
          end)

          map("n", "<leader>hN", function()
            if vim.wo.diff then
              vim.cmd.normal { "<leader>hN", bang = true }
            else
              gs.nav_hunk "prev"
            end
          end)
          map(
            "n",
            "<Leader>hm",
            "<Plug>(git-messenger)",
            { desc = "Commit Message", silent = true }
          )

          -- Actions
          map(
            { "n", "v" },
            "<leader>hs",
            ":Gitsigns stage_hunk<CR>",
            { desc = "Stage Hunk" }
          )
          map(
            { "n", "v" },
            "<leader>hr",
            ":Gitsigns reset_hunk<CR>",
            { desc = "Reset Hunk" }
          )
          map("n", "<leader>hS", gs.stage_buffer, { desc = "Stage Buffer" })
          map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Unstage" })
          map("n", "<leader>hR", gs.reset_buffer, { desc = "Reset Buffer" })
          map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview Hunk" })
          map("n", "<leader>hb", function()
            gs.blame_line { full = true }
          end, { desc = "Blame" })
          -- map("n", "<leader>tb", gs.toggle_current_line_blame)
          map("n", "<leader>hd", gs.diffthis, { desc = "Diff" })
          map("n", "<leader>hD", function()
            gs.diffthis "~"
          end, { desc = "Diff HEAD~" })
          -- map("n", "<leader>td", gs.toggle_deleted)

          -- Text object
          map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
        end,
      }
    end,
  },
  {
    "rhysd/git-messenger.vim",
    cmd = { "GitMessenger" },
    keys = "<Plug>(git-messenger)",
  },
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen" },
  },

  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
  },
  {
    "nyngwang/NeoZoom.lua",
    branch = "neo-zoom-original",
    cmd = { "NeoZoomToggle" },
  },
  {
    "gbprod/stay-in-place.nvim",
    config = function()
      require("stay-in-place").setup {}
    end,
  },
  {
    "mrshmllow/document-color.nvim",
    config = function()
      require("document-color").setup {
        mode = "foreground",
      }
    end,
  },
  -- {
  --   "folke/tokyonight.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   opts = {},
  --   config = function ()
  --     vim.cmd[[colorscheme tokyonight]]
  --   end
  -- }
  -- {
  --   "n1ghtmare/noirblaze-vim",
  --   config = function ()
  --     vim.cmd.colorscheme "noirblaze"
  --   end
  -- },
  -- {
  --   "rose-pine/neovim",
  --   name = "rose-pine",
  --   config = function()
  --     vim.cmd("colorscheme rose-pine")
  --   end
  -- },
  -- {
  --   "xero/miasma.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     vim.cmd("colorscheme miasma")
  --     vim.api.nvim_set_hl(0, "CursorLine", { bg = "#141414" })
  --     vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#1d1d1d" })
  --     vim.api.nvim_set_hl(0, "MatchParen", { underline = true, bold = true, fg = "#d7c483", bg = "#43492a", sp = "#fd9720" })
  --     vim.api.nvim_set_hl(0, "LspReferenceText", { underline = true, undercurl = false, bold = true, fg = "#5f875f", bg = "#43492a", sp = "#fd9720" })
  --     vim.api.nvim_set_hl(0, "LspReferenceRead", { underline = true, undercurl = false, bold = true, fg = "#d7c483", bg = "#43492a", sp = "#fd9720" })
  --     vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { underline = false, undercurl = true })
  --   end,
  -- },
  -- {
  --   "slugbyte/lackluster.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   init = function()
  --     -- vim.cmd.colorscheme("lackluster")
  --     vim.cmd.colorscheme("lackluster-hack") -- my favorite
  --     vim.api.nvim_set_hl(0, "CursorLine", { bg = "#202020" })
  --     vim.api.nvim_set_hl(0, "LspReferenceText", { bg = "#bbbbbb", fg = "#000000" })
  --     vim.api.nvim_set_hl(0, "LspReferenceRead", { bg = "#bbbbbb", fg = "#000000" })
  --     vim.api.nvim_set_hl(0, "Visual", { bg = "#ffff00", fg = "#000000" })
  --     -- vim.cmd.colorscheme("lackluster-mint")
  --   end,
  -- },
  -- {
  --   "morhetz/gruvbox",
  --   config = function()
  --     vim.g.
  --     vim.cmd.colorscheme("gruvbox")
  --   end,
  -- },
  -- {
  --   'sainnhe/sonokai',
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     vim.g.sonokai_enable_italic = true
  --     vim.g.sonokai_style = 'espresso'
  --     vim.cmd.colorscheme('sonokai')
  --   end
  -- },
  -- {
  --   "navarasu/onedark.nvim",
  --   priority = 1000, -- make sure to load this before all the other start plugins
  --   config = function()
  --     require('onedark').setup {
  --       style = 'warmer'
  --     }
  --     -- Enable theme
  --     require('onedark').load()
  --   end
  -- },
  -- {
  --   'maxmx03/fluoromachine.nvim',
  --   lazy = false,
  --   priority = 1000,
  --   config = function ()
  --     local fm = require 'fluoromachine'
  --
  --     fm.setup {
  --       glow = true,
  --       theme = 'fluoromachine',
  --       transparent = true,
  --     }
  --
  --     vim.cmd.colorscheme 'fluoromachine'
  --   end
  -- },
  -- {
  --   "aktersnurra/no-clown-fiesta.nvim",
  --   config = function()
  --     vim.cmd[[colorscheme no-clown-fiesta]]
  --   end,
  -- },
  -- {
  --   "dgox16/oldworld.nvim",
  --   config = function()
  --     vim.cmd[[colorscheme oldworld]]
  --     vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { undercurl = true, fg = "#ea83a5" })
  --   end,
  -- },
  -- {
  --   'sainnhe/gruvbox-material',
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     -- Optionally configure and load the colorscheme
  --     -- directly inside the plugin declaration.
  --     vim.g.gruvbox_material_enable_italic = true
  --     vim.g.gruvbox_material_background = "hard"
  --     vim.cmd.colorscheme('gruvbox-material')
  --   end
  -- },
  -- {
  --   'datsfilipe/gruvbox.nvim',
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     vim.cmd.colorscheme('gruvbox')
  --   end
  -- },
  -- {
  --   'datsfilipe/vesper.nvim',
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     vim.cmd.colorscheme('vesper')
  --   end
  -- },
  {
    "ficcdaf/ashen.nvim",
    tag = "*",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme "ashen"
      vim.api.nvim_set_hl(0, "DiffAdd", { fg = "#3fb950" })
    end,
  },
  -- {
  --   "cranberry-clockworks/coal.nvim",
  --   config = function()
  --     require('coal').setup()
  --   end
  -- },
  -- {
  --   "ckolkey/ts-node-action",
  --   dependencies = { "nvim-treesitter" },
  --   enabled = false,
  --   config = function()
  --     require("ts-node-action").setup {}
  --   end,
  -- },
  -- {
  --   "jiaoshijie/undotree",
  --   dependencies = "nvim-lua/plenary.nvim",
  --   config = true,
  --   keys = { -- load the plugin only when using it's keybinding:
  --     { "<leader>u", "<cmd>lua require('undotree').toggle()<cr>" },
  --   },
  -- },
  {
    "mbbill/undotree",
  },
  {
    "OXY2DEV/markview.nvim",
    lazy = false,
    dependencies = {
      "saghen/blink.cmp",
    },
    opts = {
      preview = {
        filetype = { "md", "rmd", "quarto", "codecompanion" },
      },
    },
  },
  "LunarVim/bigfile.nvim",
}
require("lazy").setup(plugins)
require "options"
require "config.variables"
require "mappings"
require "config.others"
vim.cmd "source $HOME/.config/nvim/vim/functions.vim"
require "commands"
