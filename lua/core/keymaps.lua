-- Set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap

-- General keymaps
keymap.set("n", "gx", ":!open <c-r><c-a><CR>") -- open URL under cursor
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "<C-p>", "<C-u>zz")
vim.keymap.set("n", "<C-n>", "<C-d>zz")

-- Split window management
keymap.set("n", "<leader>v", "<C-w>v")     -- split window vertically
keymap.set("n", "<leader>c", ":close<CR>") -- close split window
keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Diff keymaps
keymap.set("n", "<leader>cc", ":diffput<CR>")   -- put diff from current to other during diff
keymap.set("n", "<leader>cj", ":diffget 1<CR>") -- get diff from left (local) during merge
keymap.set("n", "<leader>ck", ":diffget 3<CR>") -- get diff from right (remote) during merge
keymap.set("n", "<leader>cn", "]c")             -- next diff hunk
keymap.set("n", "<leader>cp", "[c")             -- previous diff hunk

-- Quickfix keymaps
keymap.set("n", "<leader>qo", ":copen<CR>")  -- open quickfix list
keymap.set("n", "<leader>qf", ":cfirst<CR>") -- jump to first quickfix list item
keymap.set("n", "<leader>qn", ":cnext<CR>")  -- jump to next quickfix list item
keymap.set("n", "<leader>qp", ":cprev<CR>")  -- jump to prev quickfix list item
keymap.set("n", "<leader>ql", ":clast<CR>")  -- jump to last quickfix list item
keymap.set("n", "<leader>qc", ":cclose<CR>") -- close quickfix list

-- Zen-mode
keymap.set("n", "<leader>z", ":ZenMode<CR>") -- toggle maximize tab

-- Nvim--- Telescope
keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, {})
keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, {})
keymap.set('n', '<leader><leader>', require('telescope.builtin').buffers, {})
keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, {})
keymap.set('n', '<leader>/', require('telescope.builtin').current_buffer_fuzzy_find, {})
keymap.set('n', '<leader>ds', '<cmd>Telescope lsp_document_symbols symbol_width=60<CR>', {})
keymap.set('n', '<leader>ws', require('telescope.builtin').lsp_workspace_symbols, {})
keymap.set('n', 'gr', '<cmd>Telescope lsp_references<CR>')
keymap.set('n', '<leader>fi', require('telescope.builtin').lsp_incoming_calls, {})
keymap.set('n', '<leader>fm', function() require('telescope.builtin').treesitter({ default_text = ":method:" }) end)

-- Git-blame
keymap.set("n", "<leader>gb", ":Gitsigns blame<CR>") -- toggle git blame

-- Harpoon
keymap.set("n", "<leader>ha", require("harpoon.mark").add_file)
keymap.set("n", "<leader>hh", require("harpoon.ui").toggle_quick_menu)
keymap.set("n", "<leader>h1", function() require("harpoon.ui").nav_file(1) end)
keymap.set("n", "<leader>h2", function() require("harpoon.ui").nav_file(2) end)
keymap.set("n", "<leader>h3", function() require("harpoon.ui").nav_file(3) end)
keymap.set("n", "<leader>h4", function() require("harpoon.ui").nav_file(4) end)
keymap.set("n", "<leader>h5", function() require("harpoon.ui").nav_file(5) end)
keymap.set("n", "<leader>h6", function() require("harpoon.ui").nav_file(6) end)
keymap.set("n", "<leader>h7", function() require("harpoon.ui").nav_file(7) end)
keymap.set("n", "<leader>h8", function() require("harpoon.ui").nav_file(8) end)
keymap.set("n", "<leader>h9", function() require("harpoon.ui").nav_file(9) end)

-- Vim REST Console
keymap.set("n", "<leader>xr", ":call VrcQuery()<CR>") -- Run REST query

-- LSP
keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
keymap.set('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
keymap.set('n', '<leader>gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
keymap.set('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
keymap.set('n', '<leader>F', '<cmd>lua vim.lsp.buf.format({async = true})<CR>')
keymap.set('n', '<leader>f', function()
    local hunks = require("gitsigns").get_hunks()
    local format = vim.lsp.buf.format
    for i = #hunks, 1, -1 do
        local hunk = hunks[i]
        if hunk ~= nil and hunk.type ~= "delete" then
            local start = hunk.added.start
            local last = start + hunk.added.count
            -- nvim_buf_get_lines uses zero-based indexing -> subtract from last
            local last_hunk_line = vim.api.nvim_buf_get_lines(0, last - 2, last - 1, true)[1]
            local range = { start = { start, 0 }, ["end"] = { last - 1, last_hunk_line:len() } }
            vim.cmd.normal('w')
            format({ range = range })
        end
    end
end)
keymap.set('v', '<leader>f', '<cmd>lua vim.lsp.buf.format({async = true})<CR>')
keymap.set('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>')
keymap.set('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>')
keymap.set('n', 'd[', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
keymap.set('n', 'd]', '<cmd>lua vim.diagnostic.goto_next()<CR>')
keymap.set('n', '<leader>tr', '<cmd>lua vim.lsp.buf.document_symbol()<CR>')
keymap.set('i', '<C-Space>', '<cmd>lua vim.lsp.buf.completion()<CR>')

-- Filetype-specific keymaps (these can be done in the ftplugin directory instead if you prefer)
keymap.set("n", 'coi', function()
    if vim.bo.filetype == 'java' then
        require('jdtls').organize_imports();
    end
end)

keymap.set("n", '<leader>gu', function()
    if vim.bo.filetype == 'java' then
        require('jdtls').update_projects_config();
    end
end)

-- keymap.set("n", '<leader>tc', function()
--     if vim.bo.filetype == 'java' then
--         require('jdtls').test_class();
--     end
-- end)

-- keymap.set("n", '<leader>tm', function()
--     if vim.bo.filetype == 'java' then
--         require('jdtls').test_nearest_method();
--     end
-- end)

keymap.set("n", '<leader>tg', function()
    if vim.bo.filetype == 'java' then
        require('jdtls.tests').generate();
    end
end)

-- Testing
keymap.set("n", "<leader>tc", "<cmd>TestClass<cr>")
keymap.set("n", "<leader>tf", "<cmd>TestFile<cr>")
keymap.set("n", "<leader>tm", "<cmd>TestNearest<cr>")

-- Debugging
keymap.set("n", "<leader>bb", "<cmd>lua require'dap'.toggle_breakpoint()<cr>")
keymap.set("n", "<leader>bc", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>")
keymap.set("n", "<leader>bl", "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>")
keymap.set("n", '<leader>br', "<cmd>lua require'dap'.clear_breakpoints()<cr>")
keymap.set("n", '<leader>ba', '<cmd>Telescope dap list_breakpoints<cr>')
keymap.set("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>")
keymap.set("n", "<leader>dj", "<cmd>lua require'dap'.step_over()<cr>")
keymap.set("n", "<leader>dk", "<cmd>lua require'dap'.step_into()<cr>")
keymap.set("n", "<leader>do", "<cmd>lua require'dap'.step_out()<cr>")
keymap.set("n", '<leader>dd', function()
    require('dap').disconnect(); require('dapui').close();
end)
keymap.set("n", '<leader>dt', function()
    require('dap').terminate(); require('dapui').close();
end)
keymap.set("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>")
keymap.set("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>")
keymap.set("n", '<leader>di', function() require "dap.ui.widgets".hover() end)
keymap.set("n", '<leader>d?',
    function()
        local widgets = require "dap.ui.widgets"; widgets.centered_float(widgets.scopes)
    end)
keymap.set("n", '<leader>df', '<cmd>Telescope dap frames<cr>')
keymap.set("n", '<leader>dh', '<cmd>Telescope dap commands<cr>')
keymap.set("n", '<leader>sd', function() require('telescope.builtin').diagnostics({ default_text = "" }) end)

-- Fugitive
function FugitiveToggle()
    local fugitive_buf_no = vim.fn.bufnr '^fugitive:'
    local buf_win_id = vim.fn.bufwinid(fugitive_buf_no)
    if fugitive_buf_no >= 0 and buf_win_id >= 0 then
        print 'closing fugitive window'
        vim.api.nvim_win_close(buf_win_id, false)
    else
        vim.cmd ':G'
    end
end

vim.keymap.set('n', '<Leader>gs', ':lua FugitiveToggle()<CR>', { noremap = true, silent = true, desc = 'FugitiveToggle' })
vim.keymap.set('n', '<Leader>gp', ':G pull<CR>', { noremap = true, silent = true, desc = 'Git pull' })

-- Open files
vim.keymap.set('n', '<leader>o', ':!open %<CR>', { desc = 'Open file'})

-- Move lines in visual Mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Center the view
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Clear highlighting on Escape in normal mode
vim.api.nvim_set_keymap('n', '<esc>', ':noh<CR><esc>', { noremap = true, silent = true })

-- Map <esc>^[ <esc>^[ in normal mode
vim.api.nvim_set_keymap('n', '<esc>^[', '<esc>^[', { noremap = true, silent = true })

