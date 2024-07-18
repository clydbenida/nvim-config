local lint = require('lint')
local conform = require('conform')

lint.linters_by_ft = {
  javascript = { 'eslint' }
}

conform.setup({
  formatters_by_ft = {
    lua = { "stylua" },
    -- Conform will run multiple formatters sequentially
    python = { "isort", "black" },
    -- Use a sub-list to run only the first available formatter
    javascript = { { "prettierd", "prettier" } },
    typescript = { "prettier" },
    typescriptreact = { "prettier" },
  },

  -- format_on_save = {
  --   timeout_ms = 500,
  --   lsp_fallback = true,
  -- },

  format_on_save = {
    lsp_fallback = true,
    timeout_ms = 500,
    callback = function(bufnr)
      local ignore_filetypes = { "lua" }
      if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
        return { timeout_ms = 500, lsp_fallback = true }
      end
      local lines =
          vim.fn.system("git diff --unified=0 " .. vim.fn.bufname(bufnr)):gmatch("[^\n\r]+")
      local ranges = {}
      for line in lines do
        if line:find("^@@") then
          local line_nums = line:match("%+.- ")
          if line_nums:find(",") then
            local _, _, first, second = line_nums:find("(%d+),(%d+)")
            table.insert(ranges, {
              start = { tonumber(first), 0 },
              ["end"] = { tonumber(first) + tonumber(second), 0 },
            })
          else
            local first = tonumber(line_nums:match("%d+"))
            table.insert(ranges, {
              start = { first, 0 },
              ["end"] = { first + 1, 0 },
            })
          end
        end
      end
      local format = require("conform").format
      for _, range in pairs(ranges) do
        format({ range = range })
      end
    end,
  }
})

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  callback = function()
    -- try_lint without arguments runs the linters defined in `linters_by_ft`
    -- for the current filetype
    lint.try_lint(nil, {
      ignore_errors = true
    })

    -- You can call `try_lint` with a linter name or a list of names to always
    -- run specific linters, independent of the `linters_by_ft` configuration
    -- require("lint").try_lint("cspell")
  end,
})
