-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

-- save & exit
keymap.set({ "v", "n" }, "zz", ":update<CR>", { silent = true, noremap = true }) -- save if file changed
keymap.set("n", "qq", ":q<CR>", { silent = true, noremap = true })               -- exit buffer
keymap.set("n", "qa", ":qa<CR>", { silent = true, noremap = true })              -- exit neovim
keymap.set("n", "<leader>qq", ":q!<CR>", { silent = true, noremap = true })      -- force exit buffer
keymap.set("n", "<leader>qa", ":qa!<CR>", { silent = true, noremap = true })     -- force exit neovim

-- use jk to exit insert mode
keymap.set({ "i", "v" }, "jk", "<ESC>")

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>")

-- delete single character without copying into register
keymap.set("n", "x", '"_x')

-- don't touch unnamed register when pasting over visual selection
keymap.set("v", "p", "P")
-- when pasting over seleted text the removed text is coppied
keymap.set("v", "P", "p")


-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>") -- increment
keymap.set("n", "<leader>-", "<C-x>") -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v")        -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s")        -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=")        -- make split windows equal width & height
keymap.set("n", "<leader>sx", ":close<CR>")    -- close current split window
keymap.set("n", "<leader>ssh", "<C-w>h")       -- move to the left window
keymap.set("n", "<leader>ssl", "<C-w>l")       -- move to the right window
keymap.set("n", "<leader>ssj", "<C-w>j")       -- move to the bottom window
keymap.set("n", "<leader>ssk", "<C-w>k")       -- move to the top window

keymap.set("n", "<leader>to", ":tabnew<CR>")   -- open new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>") -- close current tab
keymap.set("n", "<leader>tn", ":tabn<CR>")     --  go to next tab
keymap.set("n", "<leader>tp", ":tabp<CR>")     --  go to previous tab

-- terminal management
keymap.set("n", "<leader>ot", ":terminal<CR>i")
keymap.set("t", "jk", "<C-\\><C-N>")

-- vim-maximizer
-- keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>") -- toggle split window maximization
