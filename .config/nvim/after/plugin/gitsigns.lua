if not pcall(require, "gitsigns") then
  return
end
require("gitsigns").setup {
  signs = {
    add = {
      hl = "GitSignsAdd",
      text = "▎",
      numhl = "GitSignsAddNr",
      linehl = "GitSignsAddLn",
    },
    change = {
      hl = "GitSignsChange",
      text = "▎",
      numhl = "GitSignsChangeNr",
      linehl = "GitSignsChangeLn",
    },
    delete = {
      hl = "GitSignsDelete",
      text = "契",
      numhl = "GitSignsDeleteNr",
      linehl = "GitSignsDeleteLn",
    },
    topdelete = {
      hl = "GitSignsDelete",
      text = "契",
      numhl = "GitSignsDeleteNr",
      linehl = "GitSignsDeleteLn",
    },
    changedelete = {
      hl = "GitSignsChange",
      text = "▎",
      numhl = "GitSignsChangeNr",
      linehl = "GitSignsChangeLn",
    },
  },
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    map("n", "<leader>hn", function()
      if vim.wo.diff then
        return "<leader>hn"
      end
      vim.schedule(function()
        gs.next_hunk()
      end)
      return "<Ignore>"
    end, { expr = true, desc = "Next Hunk" })

    map("n", "<leader>hN", function()
      if vim.wo.diff then
        return "<leader>hN"
      end
      vim.schedule(function()
        gs.prev_hunk()
      end)
      return "<Ignore>"
    end, { expr = true, desc = "Previous Hunk" })
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
