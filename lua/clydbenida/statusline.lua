-- Status Line

local function vim_mode()
  local modes = {
    n = 'NORMAL',
    i = 'INSERT',
    v = 'VISUAL',
    V = 'V-LINE',
    ['␖'] = 'V-BLOCK', -- This is <C-v> in Lua
    c = 'COMMAND',
    no = 'OPERATOR PENDING',
    s = 'SELECT',
    S = 'S-LINE',
    ['␓'] = 'S-BLOCK', -- This is <C-s> in Lua
    ic = 'INSERT COMPLETING',
    R = 'REPLACE',
    Rv = 'V-REPLACE',
    cv = 'VIM EX',
    ce = 'NORMAL EX',
    r = 'PROMPT',
    rm = 'MORE',
    ['r?'] = 'CONFIRM',
    ['!'] = 'SHELL',
    t = 'TERMINAL',
  }
  return modes[vim.fn.mode()] .. " | " or 'UNKNOWN'
end

local function branch_name()
  local branch = vim.fn.system("git branch --show-current 2> /dev/null | tr -d '\n'")
  if branch ~= "" then
    return branch .. " | "
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
  local cur_coords = "%5.(%l:%c%V%)"
  if vim.fn.line(".") == 1 then
    return "top |" .. cur_coords
  elseif vim.fn.line(".") == vim.fn.line("$") then
    return "bot | " .. cur_coords
  else
    local p = vim.fn.line(".") / vim.fn.line("$") * 100
    -- p = p % 1 >= .5 and math.ceil(p) or math.floor(p)
    return string.format("| %02d", p) .. "%% | %5.(%l:%c%V%)"
  end
end

vim.api.nvim_create_autocmd({ "FileType", "BufEnter", "FocusGained" }, {
  callback = function()
    vim.b.branch_name = branch_name()
    vim.b.file_name = file_name()
    vim.b.vim_mode = vim_mode()
  end
})

function Status_Line()
  return " "
      .. vim.b.vim_mode
      .. "%<"
      .. vim.b.branch_name
      .. vim.b.file_name
      .. " "
      .. "%h"
      .. "%m"
      .. "%="
      .. "%y"
      .. " "
      .. progress()
      .. " "
end

vim.opt.statusline = "%{%v:lua.Status_Line()%}"
