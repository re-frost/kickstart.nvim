return {
  'rcarriga/nvim-dap-ui',
  version = "*",
  dependencies = {
    'mfussenegger/nvim-dap',
    'ldelossa/nvim-dap-projects',
    'theHamsta/nvim-dap-virtual-text',
  },
  config = function()
    require('nvim-dap-projects').config_paths = { "nvim-dap.lua" }
    require('nvim-dap-projects').search_project_config()
    require("dapui").setup()

    vim.keymap.set('n', '<F5>', require 'dap'.continue)
    vim.keymap.set('n', '<F10>', require 'dap'.step_over)
    vim.keymap.set('n', '<F11>', require 'dap'.step_into)
    vim.keymap.set('n', '<F12>', require 'dap'.step_out)
    vim.keymap.set('n', '<leader>b', require 'dap'.toggle_breakpoint)
    vim.keymap.set('n', '<leader>B', require 'dap'.clear_breakpoints)
    vim.keymap.set('n', '<leader>lb', require 'dap'.list_breakpoints)


    local dap, dapui = require("dap"), require("dapui")
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end
  end,
}
