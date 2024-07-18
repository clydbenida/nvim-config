function ColorMyPencils(color)
  -- color = color or 'rose-pine'
  color = color or 'cyberdream'
  vim.cmd.colorscheme("gruvbox")

  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

ColorMyPencils()
