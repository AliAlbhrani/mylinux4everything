local gl = require('galaxyline')
local colors = {
  bg = '#2c323c',
  yellow = '#fabd2f',
  cyan = '#008080',
  green = '#afd700',
  orange = '#FF8800',
  magenta = '#c678dd',
  blue = '#51afef',
  red = '#ec5f67'
}

local condition = require('galaxyline.condition')
local gls = gl.section
gl.short_line_list = {'NvimTree','vista','dbui','packer'}

-- Left side
gls.left[1] = {
  RainbowRed = {
    provider = function() return '▊ ' end,
    highlight = {colors.blue,colors.bg}
  },
}

gls.left[2] = {
  ViMode = {
    provider = function()
      -- Define mode names and colors
      local mode_map = {
        n = {name = 'NORMAL', color = colors.magenta},
        i = {name = 'INSERT', color = colors.green},
        v = {name = 'VISUAL', color = colors.blue},
        [''] = {name = 'V-BLOCK', color = colors.blue},
        V = {name = 'V-LINE', color = colors.blue},
        c = {name = 'COMMAND', color = colors.red},
        no = {name = 'NORMAL', color = colors.magenta},
        s = {name = 'SELECT', color = colors.orange},
        S = {name = 'S-LINE', color = colors.orange},
        [''] = {name = 'S-BLOCK', color = colors.orange},
        ic = {name = 'INSERT', color = colors.yellow},
        R = {name = 'REPLACE', color = colors.red},
        Rv = {name = 'REPLACE', color = colors.red},
        cv = {name = 'COMMAND', color = colors.red},
        ce = {name = 'COMMAND', color = colors.red},
        r = {name = 'PROMPT', color = colors.cyan},
        rm = {name = 'MORE', color = colors.cyan},
        ['r?'] = {name = 'CONFIRM', color = colors.cyan},
        ['!'] = {name = 'SHELL', color = colors.red},
        t = {name = 'TERMINAL', color = colors.red}
      }
      
      local current_mode = vim.fn.mode()
      local mode_info = mode_map[current_mode] or {name = 'UNKNOWN', color = colors.red}
      
      -- Set the highlight color dynamically
      vim.api.nvim_command('hi GalaxyViMode guifg='..mode_info.color..' guibg='..colors.bg..' gui=bold')
      
      return '  ' .. mode_info.name .. ' '
    end,
    highlight = {colors.red,colors.bg,'bold'},
  },
}

gls.left[3] = {
  GitBranch = {
    provider = function()
      local branch = require('galaxyline.provider_vcs').get_git_branch()
      if not branch then return '' end
      
      -- Try multiple ways to get git status
      local function get_git_status()
        -- Method 1: Try with upstream
        local handle = io.popen('git rev-list --count --left-right @{upstream}...HEAD 2>/dev/null')
        if handle then
          local result = handle:read('*a')
          handle:close()
          if result and result ~= '' then
            local behind, ahead = result:match('(%d+)%s+(%d+)')
            if behind and ahead then
              return tonumber(behind), tonumber(ahead)
            end
          end
        end
        
        -- Method 2: Try with origin/branch
        handle = io.popen('git rev-list --count --left-right origin/' .. branch .. '...HEAD 2>/dev/null')
        if handle then
          local result = handle:read('*a')
          handle:close()
          if result and result ~= '' then
            local behind, ahead = result:match('(%d+)%s+(%d+)')
            if behind and ahead then
              return tonumber(behind), tonumber(ahead)
            end
          end
        end
        
        -- Method 3: Check git status porcelain
        handle = io.popen('git status --porcelain=v1 --branch 2>/dev/null')
        if handle then
          local result = handle:read('*a')
          handle:close()
          if result then
            local ahead_match = result:match('%[ahead (%d+)')
            local behind_match = result:match('%[behind (%d+)')
            return tonumber(behind_match) or 0, tonumber(ahead_match) or 0
          end
        end
        
        return 0, 0
      end
      
      local behind, ahead = get_git_status()
      
      local status = ''
      if ahead > 0 then
        status = status .. '↑' .. ahead
      end
      if behind > 0 then
        status = status .. '↓' .. behind
      end
      
      local branch_display = '  ' .. branch
      if status ~= '' then
        branch_display = branch_display .. ' ' .. status
      end
      
      return branch_display .. ' '
    end,
    condition = condition.check_git_workspace,
    separator = ' ',
    separator_highlight = {'NONE',colors.bg},
    highlight = {colors.cyan,colors.bg,'bold'},
  }
}

-- Add filename
gls.left[4] = {
  FileName = {
    provider = 'FileName',
    condition = condition.buffer_not_empty,
    separator = ' | ',
    separator_highlight = {colors.magenta,colors.bg},
    highlight = {colors.yellow,colors.bg,'bold'}
  }
}

-- Right side
gls.right[1] = {
  FileEncode = {
    provider = 'FileEncode',
    condition = condition.hide_in_width,
    separator = ' ',
    separator_highlight = {'NONE',colors.bg},
    highlight = {colors.green,colors.bg,'bold'}
  }
}

gls.right[2] = {
  LineInfo = {
    provider = 'LineColumn',
    separator = ' | ',
    separator_highlight = {'NONE',colors.bg},
    highlight = {colors.blue,colors.bg},
  },
}

gls.right[3] = {
  PerCent = {
    provider = 'LinePercent',
    separator = ' ',
    separator_highlight = {'NONE',colors.bg},
    highlight = {colors.blue,colors.bg,'bold'},
  }
}

-- Short line
gls.short_line_left[1] = {
  BufferType = {
    provider = 'FileTypeName',
    separator = ' ',
    separator_highlight = {'NONE',colors.bg},
    highlight = {colors.blue,colors.bg,'bold'}
  }
}

gls.short_line_left[2] = {
  SFileName = {
    provider =  'SFileName',
    condition = condition.buffer_not_empty,
    highlight = {colors.yellow,colors.bg,'bold'}
  }
}
