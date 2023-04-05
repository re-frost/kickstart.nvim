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
    --    require("dapui").open()
    --    require("dapui").close()
    --    require("dapui").toggle()
  end,
}
