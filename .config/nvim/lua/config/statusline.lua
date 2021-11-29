local gl = require('galaxyline')
local condition = require('galaxyline.condition')
local fileinfo = require('galaxyline.provider_fileinfo')
local gls = gl.section
gl.short_line_list = {'NvimTree','vista','dbui','packer'}
local mycolors = {
  bg = '#3c3836',
  fg = '#a89984',
  yellow = '#fabd2f',
  aqua = '#83a598',
  red = '#ec5f67',
  yellowopaco = '#ECBE7B'
}

local mode_color = {
  n = mycolors.fg,
  i = mycolors.aqua,
  v=mycolors.yellow,
  [''] = mycolors.yellow,
  V=mycolors.yellow,
  c = mycolors.fg,
  s = mycolors.yellow,
  S = mycolors.yellow,
}

gls.left[2] = {
  ViMode = {
    provider = function()
      vim.api.nvim_command('hi GalaxyViMode guifg='..mode_color[vim.api.nvim_get_mode().mode] .. ' guibg='..mycolors.bg)
      return '▊   '
    end,
    separator = ' ',
    separator_highlight = {mycolors.fg,mycolors.bg}
  },
}
gls.left[3] = {
  FileSize = {
    provider = 'FileSize',
    condition = condition.buffer_not_empty,
    highlight = {mycolors.fg,mycolors.bg},
    separator = ' ',
    separator_highlight = {'NONE',mycolors.bg},
  }
}
gls.left[4] ={
  FileIcon = {
    provider = 'FileIcon',
    condition = condition.buffer_not_empty,
    highlight = {require('galaxyline.provider_fileinfo').get_file_icon_color,mycolors.bg},
  },
}

gls.left[5] = {
  FilePath = {
    provider = function()
      local file = ''
      local cwd = vim.loop.cwd()
      local absolute_path = vim.api.nvim_buf_get_name(0)
      local rel_path = absolute_path:gsub(cwd .. '/', '')
      local filename = absolute_path:match("^.+/(.+)$")
      if absolute_path ~= '' and filename ~= nil then
        file = rel_path:gsub(filename:gsub("[%(%)%.%+%-%*%?%[%]%^%$%%]", "%%%1"),'')
      else
        file = cwd .. ' '
        if vim.bo.modified then
          file = file .. '✚'
        end
      end
      return file
    end,
    highlight = {mycolors.fg,mycolors.bg},
  }
}

gls.left[6] = {
  FileName = {
    provider = function ()
      return fileinfo.get_current_file_name('✚') .. ' '
    end,
    condition = condition.buffer_not_empty,
    highlight = {mycolors.fg,mycolors.bg,'bold'},
  }
}

gls.left[7] = {
  DiagnosticError = {
    provider = 'DiagnosticError',
    icon = '  ',
    highlight = {mycolors.red,mycolors.bg}
  }
}
gls.left[8] = {
  DiagnosticWarn = {
    provider = 'DiagnosticWarn',
    icon = '  ',
    highlight = {mycolors.yellowopaco,mycolors.bg},
  }
}

gls.left[9] = {
  DiagnosticHint = {
    provider = 'DiagnosticHint',
    icon = '  ',
    highlight = {mycolors.fg,mycolors.bg},
  }
}

gls.left[10] = {
  DiagnosticInfo = {
    provider = 'DiagnosticInfo',
    icon = '  ',
    highlight = {mycolors.fg,mycolors.bg},
  }
}

gls.left[10] = {
  PackageInfoStatus = {
    provider = function()
      return require("package-info").get_status()
    end,
    condition = function()
      local filename = vim.api.nvim_buf_get_name(0):match("^.+/(.+)$")
      if  filename == 'package.json' then
        return true
      end
    end,
    highlight = {mycolors.fg,mycolors.bg},
  }
}

gls.mid[1] = {
  ShowLspClient = {
    provider = 'GetLspClient',
    condition = function ()
      local tbl = {['dashboard'] = true,['']=true}
      if tbl[vim.bo.filetype] then
        return false
      end
      return true
    end,
    -- icon = ' LSP: ',
    highlight = {mycolors.fg,mycolors.bg}
  }
}


gls.right[1] = {
  GitIcon = {
    provider = function() return ' ' end,
    condition = condition.check_git_workspace,
    separator = ' ',
    separator_highlight = {'NONE',mycolors.bg},
    highlight = {mycolors.fg,mycolors.bg,'bold'},
  }
}

gls.right[2] = {
  GitBranch = {
    provider = 'GitBranch',
    condition = condition.check_git_workspace,
    highlight = {mycolors.fg,mycolors.bg,'bold'},
  }
}

gls.right[3] = {
  DiffAdd = {
    provider = 'DiffAdd',
    condition = condition.hide_in_width,
    icon = '+',
    highlight = {mycolors.fg,mycolors.bg},
    separator = ' ',
    separator_highlight = {'NONE',mycolors.bg},
  }
}
gls.right[4] = {
  DiffModified = {
    provider = 'DiffModified',
    condition = condition.hide_in_width,
    icon = '~',
    highlight = {mycolors.fg,mycolors.bg},
  }
}

gls.right[5] = {
  DiffRemove = {
    provider = 'DiffRemove',
    condition = condition.hide_in_width,
    icon = '-',
    highlight = {mycolors.fg,mycolors.bg},
  }
}

gls.right[6] = {
  PerCent = {
    provider = function()
      return fileinfo.current_line_percent() .. ' ' .. vim.fn.col(".") .. "  "
    end,
    highlight = {mycolors.fg,mycolors.bg,'bold'},
    separator = ' ',
    separator_highlight = {'NONE',mycolors.bg},
  }
}
gls.right[7] = {
  FileEncode = {
    provider = 'FileEncode',
    condition = condition.hide_in_width,
    highlight = {mycolors.fg,mycolors.bg,'bold'}
  }
}

gls.right[8] = {
  FileFormat = {
    provider = 'FileFormat',
    condition = condition.hide_in_width,
    separator = ' ',
    separator_highlight = {'NONE',mycolors.bg},
    highlight = {mycolors.fg,mycolors.bg,'bold'}
  }
}

gls.right[9] = {
  RainbowBlue = {
    provider = function()
      vim.api.nvim_command('hi RainbowBlue guifg='..mode_color[vim.api.nvim_get_mode().mode] .. ' guibg='..mycolors.bg)
      return ' ▊'
    end,
    highlight = {mycolors.fg,mycolors.bg},
    separator = ' ',
    separator_highlight = {'NONE',mycolors.bg},
  },
}

gls.short_line_left[1] = {
  BufferType = {
    provider = 'FileTypeName',
    separator = ' ',
    separator_highlight = {'NONE',mycolors.bg},
    highlight = {mycolors.fg,mycolors.bg,'bold'}
  }
}

gls.short_line_left[2] = {
  SFileName = {
    provider =  'SFileName',
    condition = condition.buffer_not_empty,
    highlight = {mycolors.fg,mycolors.bg,'bold'}
  }
}

gls.short_line_right[1] = {
  BufferIcon = {
    provider= 'BufferIcon',
    highlight = {mycolors.fg,mycolors.bg}
  }
}
