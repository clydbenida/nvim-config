local icon = require("nvim-web-devicons")

local function vim_mode()
  local modes = {
    n = 'NORMAL',
    i = 'INSERT',
    v = 'VISUAL',
    V = 'VISUAL',
    ['␖'] = 'VISUAL', -- This is <C-v> in Lua
    c = 'COMMAND',
    R = 'REPLACE',
  }
  local current_mode = vim.api.nvim_get_mode().mode

  return modes[current_mode] or 'UNKNOWN'
end

local function mode_color()
  local mode_col_groups = {
    NORMAL = "StatusLineNormal",
    VISUAL = "StatusLineVisual",
    INSERT = "StatusLineInsert",
    COMMAND = "StatusLineCommand",
    REPLACE = "StatusLineReplace",
  }
  return mode_col_groups[vim_mode()] or 'StatusLine'
end

local function branch_name()
  local branch = vim.fn.system("git branch --show-current 2> /dev/null | tr -d '\n'")
  if branch ~= "" then
    return branch
  else
    return ""
  end
end

local function file_name()
  local root_path = vim.fn.getcwd()
  local root_dir = root_path:match("[^/]+$")
  local home_path = vim.fn.expand("%:~")
  local overlap, _ = home_path:find(root_dir)
  if home_path == "" then
    return root_path:gsub("/Users/[^/]+", "~")
  elseif overlap then
    return home_path:sub(overlap)
  else
    return home_path
  end
end

local function progress()
  local cur_coords = "Ln %l, Col %c%V%"
  if vim.fn.line(".") == 1 then
    return "top | " .. cur_coords
  elseif vim.fn.line(".") == vim.fn.line("$") then
    return "bot | " .. cur_coords
  else
    local p = vim.fn.line(".") / vim.fn.line("$") * 100
    -- p = p % 1 >= .5 and math.ceil(p) or math.floor(p)
    return "%#" .. "StatusLineSecondary" .. "#"
        .. string.format(" ◀ %02d", p)
        .. "%% "
        .. "%#" .. "StatusLine" .. "#"
        .. "%#" .. mode_color() .. "#"
        .. " ◀ %14.(" .. cur_coords .. ") "
        .. "%#" .. "StatusLine" .. "#"
  end
end

local function get_file_ext()
  return vim.fn.expand("%:e")
end

-- Should be only used for details that are not updating constantly
vim.api.nvim_create_autocmd({ "FileType", "BufEnter", "FocusGained" }, {
  callback = function()
    -- Status colors
    local function setStatusColors()
      vim.api.nvim_set_hl(0, 'StatusLineNormal', { fg = '#ffffff', bg = '#005f87', bold = true })
      vim.api.nvim_set_hl(0, 'StatusLineInsert', { fg = '#ffffff', bg = '#919f0e', bold = true })
      vim.api.nvim_set_hl(0, 'StatusLineVisual', { fg = '#ffffff', bg = '#875f00', bold = true })
      vim.api.nvim_set_hl(0, 'StatusLineReplace', { fg = '#ffffff', bg = '#870000', bold = true })
      vim.api.nvim_set_hl(0, 'StatusLineCommand', { fg = '#ffffff', bg = '#696969', bold = true })
      vim.api.nvim_set_hl(0, 'StatusLineSecondary', { fg = '#ffffff', bg = '#545454', bold = true }) -- Default statusline
      vim.api.nvim_set_hl(0, 'StatusLine', { fg = '#ffffff', bg = '#303030', bold = true })          -- Default statusline
    end

    local file_ext = vim.fn.expand("%:e")
    local file_icon = icon.get_icon("", file_ext)

    setStatusColors()
    vim.b.file_icon = file_icon or ""
    vim.b.branch_name = branch_name()
    vim.b.file_name = file_name()
  end
})

function Status_Line()
  return "%#" .. mode_color() .. "#"
      .. " "
      .. vim_mode()
      .. " ▶ "
      .. "%#" .. "StatusLine" .. "#"
      .. "%#" .. "StatusLineSecondary" .. "#"
      .. " "
      .. "%<"
      .. vim.b.branch_name
      .. " ▶ "
      .. "%#" .. "StatusLine" .. "#"
      .. " "
      .. vim.b.file_name
      .. " "
      .. "%h"
      .. "%m"
      .. "%="
      .. vim.b.file_icon
      .. " "
      .. get_file_ext()
      .. " "
      .. progress()
end

vim.o.statusline = "%{%v:lua.Status_Line()%}"
