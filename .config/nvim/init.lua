vim.g.mapleader = " "
vim.cmd.colorscheme "farout"
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
      }
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  -- {
  --   'barrett-ruth/import-cost.nvim',
  --   build = 'sh install.sh bun',
  --   config = true
  -- },
  {
    'mikesmithgh/kitty-scrollback.nvim',
    enabled = true,
    lazy = true,
    cmd = { 'KittyScrollbackGenerateKittens', 'KittyScrollbackCheckHealth' },
    event = { 'User KittyScrollbackLaunch' },
    -- version = '*', -- latest stable version, may have breaking changes if major version changed
    -- version = '^3.0.0', -- pin major version, include fixes and features that do not have breaking changes
    config = function()
      require('kitty-scrollback').setup()
    end,
  },
  "Marskey/telescope-sg",
  -- {
  --   "nvim-telescope/telescope-fzf-native.nvim",
  --   build =
  --   "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
  -- },
  "nvim-telescope/telescope-ui-select.nvim",
  "kyazdani42/nvim-web-devicons",
  "norcalli/nvim-colorizer.lua",
  {
    "karb94/neoscroll.nvim",
    opts = {
      mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "zt", "zz", "zb" },
    },
  },
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
  "wellle/targets.vim",
  {
    "folke/which-key.nvim",
    opts = {
      plugins = {
        presets = {
          operators = false,
          motions = false,
          text_objects = false,
          windows = true,
          nav = true,
          z = true,
          g = true,
        },
      },
      window = {
        border = "single",
      },
    },
  },
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
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "nvimtools/none-ls.nvim",
        dependencies = {
          "nvimtools/none-ls-extras.nvim",
        }
      },
      "hrsh7th/cmp-nvim-lsp",
      {
        "pmizio/typescript-tools.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
          require("typescript-tools").setup {}
        end,
      },
    },
  },
  {
    "numToStr/Comment.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    config = function()
      local prehook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()
      require"Comment".setup({
        pre_hook = prehook,
        post_hook = nil,
      })
    end,
    keys = { "gcc", "gc", "gb", "gbc" },
    lazy = false,
    event = "BufReadPre",

  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    opts = {
      enable_autocmd = false,
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },
  {
    "j-hui/fidget.nvim",
    tag = "legacy",
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
  {
    "folke/zen-mode.nvim",
    dependencies = {
      {
        "folke/twilight.nvim",
      },
    },
    cmd = { "ZenMode" },
  },
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
    ft = "json",
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
    "epwalsh/obsidian.nvim",
    lazy = true,
    event = {
      "BufReadPre " .. vim.fn.expand "~" .. "/Documents/second_brain/**.md",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
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
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "onsails/lspkind-nvim",
      "windwp/nvim-autopairs",
      "jcha0713/cmp-tw2css",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-buffer",
      {
        "hrsh7th/cmp-nvim-lua",
        ft = "lua",
      },
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "lukas-reineke/cmp-rg",
      {
        "petertriho/cmp-git",
        ft = "gitcommit",
        config = function()
          require("cmp_git").setup()
        end,
      },
      {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
          require("copilot").setup {
            filetypes = {
              markdown = true,
              sh = function()
                if
                  string.match(
                    vim.fs.basename(vim.api.nvim_buf_get_name(0)),
                    "^%.env.*"
                  )
                then
                  return false
                end
                return true
              end,
            },
            suggestion = {
              enabled = true,
              auto_trigger = true,
              debounce = 75,
              keymap = {
                accept = "<M-l>",
                accept_word = "<C-n>",
                accept_line = "<C-e>",
                next = "<M-]>",
                prev = "<M-[>",
                dismiss = "<C-]>",
              },
            },
          }
        end,
      },
    },
    config = function()
      local luasnip = require "luasnip"

      luasnip.config.setup {
        update_events = "TextChanged,TextChangedI",
        region_check_events = "InsertEnter",
      }

      require("luasnip.loaders.from_lua").lazy_load {
        paths = "~/Documents/snippets/",
      }

      local utils = require "utils"
      local t = utils.t
      local lspkind = require "lspkind"
      local cmp = require "cmp"

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        formatting = {
          format = lspkind.cmp_format(),
        },
        sources = cmp.config.sources({
          { name = "nvim_lsp_signature_help" },
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
          { name = "path" },
        }, {
          { name = "rg" },
        }),
        mapping = {
          ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
          ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
          ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
          ["<C-x>"] = cmp.mapping {
            c = cmp.mapping.close(),
            i = function(fallback)
              if cmp.visible() then
                cmp.close()
              elseif require("copilot.suggestion").is_visible() then
                require("copilot.suggestion").dismiss()
              else
                fallback()
              end
            end,
          },
          ["<C-j>"] = cmp.mapping {
            c = cmp.mapping.select_next_item {
              behavior = cmp.SelectBehavior.Insert,
            },
            i = function(fallback)
              if cmp.visible() then
                cmp.select_next_item { behavior = cmp.SelectBehavior.Insert }
              elseif require("copilot.suggestion").is_visible() then
                require("copilot.suggestion").accept()
              else
                fallback()
              end
            end,
          },
          ["<C-k>"] = cmp.mapping(
            cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
            { "i", "c" }
          ),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<C-l>"] = cmp.mapping {
            i = function(fallback)
              if cmp.visible() then
                cmp.confirm {
                  behavior = cmp.ConfirmBehavior.Replace,
                  select = true,
                }
              elseif require("copilot.suggestion").is_visible() then
                require("copilot.suggestion").accept_line()
              else
                fallback()
              end
            end,
            c = function(fallback)
              if cmp.visible() then
                cmp.confirm({
                  behavior = cmp.ConfirmBehavior.Replace,
                  select = true,
                }, function()
                  return vim.api.nvim_feedkeys(t "<CR>", "c", true)
                end)
              else
                fallback()
              end
            end,
          },
          ["<CR>"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          },
        },
        window = {
          completion = cmp.config.window.bordered {
            winhighlight = "FloatBorder:FloatBorder",
          },
          documentation = cmp.config.window.bordered {
            winhighlight = "FloatBorder:FloatBorder",
          },
        },
      }

      cmp.setup.filetype("lua", {
        sources = cmp.config.sources({
          { name = "nvim_lsp_signature_help" },
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "nvim_lua" },
          { name = "buffer" },
          { name = "path" },
        }, {
          { name = "rg" },
        }),
      })

      require("cmp-tw2css").setup()

      cmp.setup.filetype({ "css", "scss", "less", "sass" }, {
        sources = cmp.config.sources({
          { name = "nvim_lsp_signature_help" },
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "cmp-tw2css" },
          { name = "buffer" },
          { name = "path" },
        }, {
          { name = "rg" },
        }),
      })

      cmp.setup.filetype("gitcommit", {
        sources = cmp.config.sources({
          { name = "git" },
        }, {
          { name = "nvim_lsp" },
          { name = "buffer" },
        }),
      })

      cmp.setup.cmdline("?", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })
      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          {
            name = "cmdline",
            option = {
              ignore_cmds = { "Man", "!" },
            },
          },
        }),
      })
      --
      -- cmp.event:on("menu_opened", function()
      --   vim.b.copilot_suggestion_hidden = true
      -- end)
      --
      -- cmp.event:on("menu_closed", function()
      --   vim.b.copilot_suggestion_hidden = false
      -- end)
      --
      local npairs = require "nvim-autopairs"
      local cmp_autopairs = require "nvim-autopairs.completion.cmp"

      npairs.setup {
        check_ts = true,
        break_undo = false,
        enable_abbr = true,
      }

      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

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
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
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
    event = "BufRead",
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
  {
    "ckolkey/ts-node-action",
    dependencies = { "nvim-treesitter" },
    enabled = false,
    config = function()
      require("ts-node-action").setup {}
    end,
  },
}
require("lazy").setup(plugins)
require "options"
require "config.variables"
require "mappings"
require "config.others"
vim.cmd "source $HOME/.config/nvim/vim/functions.vim"
require "commands"
