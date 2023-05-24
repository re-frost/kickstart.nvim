-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
  -- NOTE: Yes, you can install new plugins here!
  'mfussenegger/nvim-dap',
  -- NOTE: And you can specify dependencies as well
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Add your own debuggers here
    'leoluz/nvim-dap-go',

    'ldelossa/nvim-dap-projects',
    'theHamsta/nvim-dap-virtual-text',
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_setup = true,

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        'delve',
      },
    }
    require("nvim-dap-virtual-text").setup {
      enabled = true,                     -- enable this plugin (the default)
      enabled_commands = true,            -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
      highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
      highlight_new_as_changed = false,   -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
      show_stop_reason = true,            -- show stop reason when stopped for exceptions
      commented = false,                  -- prefix virtual text with comment string
      only_first_definition = true,       -- only show virtual text at first definition (if there are multiple)
      all_references = false,             -- show virtual text on all all references of the variable (not only definitions)
      -- A callback that determines how a variable is displayed or whether it should be omitted
      -- @param variable Variable https://microsoft.github.io/debug-adapter-protocol/specification#Types_Variable
      -- @param buf number
      -- @param stackframe dap.StackFrame https://microsoft.github.io/debug-adapter-protocol/specification#Types_StackFrame
      -- @param node userdata tree-sitter node identified as variable definition of reference (see `:h tsnode`)
      -- @return string|nil A text how the virtual text should be displayed or nil, if this variable shouldn't be displayed
      display_callback = function(variable, _buf, _stackframe, _node)
        return variable.name .. ' = ' .. variable.value
      end,

      -- experimental features:
      virt_text_pos = 'eol',  -- position of virtual text, see `:h nvim_buf_set_extmark()`
      all_frames = false,     -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
      virt_lines = false,     -- show virtual lines instead of virtual text (will flicker!)
      virt_text_win_col = nil -- position the virtual text at a fixed window column (starting from the first text column) ,
      -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
    }
    -- You can provide additional configuration to the handlers,
    -- see mason-nvim-dap README for more information
    -- require('mason-nvim-dap').setup_handlers()

    -- Basic debugging keymaps, feel free to change to your liking!
    vim.keymap.set('n', '<F5>', dap.continue)
    vim.keymap.set('n', '<F1>', dap.step_into)
    vim.keymap.set('n', '<F2>', dap.step_over)
    vim.keymap.set('n', '<F3>', dap.step_out)
    vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint)
    vim.keymap.set('n', '<leader>cb', dap.clear_breakpoints)
    vim.keymap.set('n', '<leader>B', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end)
    require('nvim-dap-projects').config_paths = { "nvim-dap.lua" }
    require('nvim-dap-projects').search_project_config()
    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
        },
      },
    }

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- Install golang specific config
    require('dap-go').setup()
  end,
}
