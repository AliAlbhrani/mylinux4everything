vim.opt.termguicolors = true
local bufferline = require('bufferline')
bufferline.setup {
    options = {
	mode = "buffers", -- set to "tabs" to only show tabpages instead
        style_preset = bufferline.style_preset.default, -- or bufferline.style_preset.minimal,
        themable = true , -- allows highlight groups to be overriden i.e. sets highlights as default
        numbers =  "ordinal",
        close_command = "bdelete! %d",       -- can be a string | function, | false see "Mouse actions"
        right_mouse_command = "bdelete! %d", -- can be a string | function | false, see "Mouse actions"
        left_mouse_command = "buffer %d",    -- can be a string | function, | false see "Mouse actions"
        middle_mouse_command = nil,          -- can be a string | function, | false see "Mouse actions"
        indicator = {
            icon = '▎', -- this should be omitted if indicator style is not 'icon'
            style = 'icon' ,
        },
        buffer_close_icon = '󰅖',
        modified_icon = '● ',
        close_icon = ' ',
        left_trunc_marker = ' ',
        right_trunc_marker = ' ',
        max_name_length = 18,
        max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
        truncate_names = true, -- whether or not tab names should be truncated
        tab_size = 18,
        diagnostics = "nvim_lsp" ,
        diagnostics_update_in_insert = false, -- only applies to coc
        diagnostics_update_on_event = true, -- use nvim's diagnostic handler
        -- The diagnostics indicator can be set to nil to keep the buffer name highlight but delete the highlighting
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
            return "("..count..")"
        end,
        -- NOTE: this will be called a lot so don't do any heavy processing here
        custom_filter = function(buf_number, buf_numbers)
            -- filter out filetypes you don't want to see
            if vim.bo[buf_number].filetype ~= "<i-dont-want-to-see-this>" then
                return true
            end
            -- filter out by buffer name
            if vim.fn.bufname(buf_number) ~= "<buffer-name-I-dont-want>" then
                return true
            end
            -- filter out based on arbitrary rules
            -- e.g. filter out vim wiki buffer from tabline in your work repo
            if vim.fn.getcwd() == "<work-repo>" and vim.bo[buf_number].filetype ~= "wiki" then
                return true
            end
            -- filter out by it's index number in list (don't show first buffer)
            if buf_numbers[1] ~= buf_number then
                return true
            end
        end,
        offsets = {
            {
                filetype = "NvimTree",
                text = "File Explorer"  ,
                text_align =  "center", 
                separator = true
            }
        },
        color_icons = true , -- whether or not to add the filetype icon highlights
        get_element_icon = function(element)
          local icon, hl = require('nvim-web-devicons').get_icon_by_filetype(element.filetype, { default = false })
          return icon, hl
        end,
        show_buffer_icons = true , -- disable filetype icons for buffers
        show_buffer_close_icons = true ,
        show_close_icon = true ,
        show_tab_indicators = true ,
        show_duplicate_prefix = true , -- whether to show duplicate buffer prefix
        duplicates_across_groups = true, -- whether to consider duplicate paths in different groups as duplicates
        persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
        move_wraps_at_ends = false, -- whether or not the move command "wraps" at the first or last position
        separator_style =  "slope" ,
        enforce_regular_tabs = false ,
        always_show_bufferline = true ,
        auto_toggle_bufferline = true ,
        hover = {
            enabled = true,
            delay = 200,
            reveal = {'close'}
        },
        sort_by = 'insert_at_end',
        pick = {
          alphabet = "abcdefghijklmopqrstuvwxyzABCDEFGHIJKLMOPQRSTUVWXYZ1234567890",
        },
    }
}

vim.keymap.set("n","<leader>1",function() vim.cmd("BufferLineGoToBuffer 1") end)
vim.keymap.set("n","<leader>2",function() vim.cmd("BufferLineGoToBuffer 2") end)
vim.keymap.set("n","<leader>3",function() vim.cmd("BufferLineGoToBuffer 3") end)
vim.keymap.set("n","<leader>4",function() vim.cmd("BufferLineGoToBuffer 4") end)
vim.keymap.set("n","<leader>5",function() vim.cmd("BufferLineGoToBuffer 5") end)
vim.keymap.set("n","<leader>6",function() vim.cmd("BufferLineGoToBuffer 6") end)
vim.keymap.set("n","<leader>7",function() vim.cmd("BufferLineGoToBuffer 7") end)
vim.keymap.set("n","<leader>8",function() vim.cmd("BufferLineGoToBuffer 8") end)
vim.keymap.set("n","<leader>9",function() vim.cmd("BufferLineGoToBuffer 9") end)
vim.keymap.set("n","<leader>$",function() vim.cmd("BufferLineGoToBuffer -1") end)
-- vim.keymap.set("n","<leader>3","<Cmd>BufferLineGoToBuffer 3<CR>")
-- vim.keymap.set("n","<leader>4","<Cmd>BufferLineGoToBuffer 4<CR>")
-- vim.keymap.set("n","<leader>5","<Cmd>BufferLineGoToBuffer 5<CR>")
-- vim.keymap.set("n","<leader>6","<Cmd>BufferLineGoToBuffer 6<CR>")
-- vim.keymap.set("n","<leader>7","<Cmd>BufferLineGoToBuffer 7<CR>")
-- vim.keymap.set("n","<leader>8","<Cmd>BufferLineGoToBuffer 8<CR>")
-- vim.keymap.set("n","<leader>9","<Cmd>BufferLineGoToBuffer 9<CR>")
-- vim.keymap.set("n","<leader>$","<Cmd>BufferLineGoToBuffer -1<CR>")

vim.keymap.set("n","L",vim.cmd.BufferLineCycleNext)
vim.keymap.set("n","H",vim.cmd.BufferLineCyclePrev)

vim.keymap.set("n","<leader>bo",vim.cmd.BufferLineCloseOthers)
vim.keymap.set("n","<leader>bd",vim.cmd.BufferLinePickClose)
-- vim.cmd.set("<mymap> :BufferLineMoveNext<CR>")
-- vim.cmd.set("<mymap> :BufferLineMovePrev<CR>")
-- vim.cmd.set("<mymap> :lua require'bufferline'.move_to(1)<CR>")
-- vim.cmd.set("<mymap> :lua require'bufferline'.move_to(-1)<CR>")
-- vim.cmd.set("be :BufferLineSortByExtension<CR>")
-- vim.cmd.set("bd :BufferLineSortByDirectory<CR>")
-- vim.cmd.set("<mymap> :lua require'bufferline'.sort_by(function (buf_a, buf_b) return buf_a.id < buf_b.id end)<CR>")
