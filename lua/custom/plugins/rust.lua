-- sudo pacman -S rust-src, rust-analyzer   --- necessary
return {
  'rust-lang/rust.vim',
  'simrat39/rust-tools.nvim',
  'lvimuser/lsp-inlayhints.nvim',
  config = function()
    require('rust-tools').setup {
      server = {
        on_attach = function(_, bufnr)
          -- Hover actions
          vim.keymap.set("n", "<C-space>", require("rust-tools").hover_actions.hover_actions, { buffer = bufnr })
          -- Code action groups
          vim.keymap.set("n", "<Leader>a", require("rust-tools").code_action_group.code_action_group, { buffer = bufnr })
        end,
      },
      inlay_hints = true,
      -- debugging stuff
      dap = {
        adapter = {
          type = "executable",
          command = "/usr/bin/lldb-vscode",
          name = "rt_lldb",
        },
      },
    }
  end
}
