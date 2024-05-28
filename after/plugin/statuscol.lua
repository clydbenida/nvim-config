local builtin = require("statuscol.builtin")

require("statuscol").setup {
  {
    setopt = true,
    relculright = true,
    segments = {
      {
        sign = {
          name = { '.*' },
          namespace = { '.*' },
          -- namespace = { ".*diagnostic.*" },
          -- name = { "todo%-sign.*" }, -- WARN: escape the dash `-`
          maxwidth = 1,
          colwidth = 2,
          auto = false,
          wrap = true,
        },
      },
      {
        text = { builtin.lnumfunc, ' ' },
        colwidth = 1,
        click = 'v:lua.ScLa',
      },
      {
        sign = {
          name = { 'GitSigns*' },
          namespace = { 'gitsigns' },
          colwidth = 1,
        },
        click = 'v:lua.ScSa',
      },
      {
        text = { builtin.foldfunc, ' ' },
        hl = 'FoldColumn',
        wrap = true,
        colwidth = 1,
        click = 'v:lua.ScFa',
      },
    },
  }
}
