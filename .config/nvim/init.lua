require("core.options")  -- Load general options
require("core.keymaps")  -- Load general keymaps
require("core.snippets") -- Custom code snippets

-- Install package manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Import color theme based on environment variable NVIM_THEME
local default_color_scheme = "nord"
local env_var_nvim_theme = os.getenv("NVIM_THEME") or default_color_scheme

-- Define a table of theme modules
local themes = {
    nord = "plugins.themes.nord",
    onedark = "plugins.themes.onedark",
}

-- Setup plugins
require("lazy").setup({
    { "codota/tabnine-nvim", build = "./dl_binaries.sh" },
    require(themes.nord),
    require("plugins.telescope"),
    require("plugins.treesitter"),
    require("plugins.lsp"),
    require("plugins.autocompletion"),
    require("plugins.none-ls"),
    require("plugins.lualine"),
    require("plugins.bufferline"),
    require("plugins.neotree"),
    require("plugins.comment"),
    require("plugins.gitsigns"),
    ui = {
        icons = vim.g.have_nerd_font and {} or {
            cmd = "⌘",
            config = "🛠",
            event = "📅",
            ft = "📂",
            init = "⚙",
            keys = "🗝",
            plugin = "🔌",
            runtime = "💻",
            require = "🌙",
            source = "📄",
            start = "🚀",
            task = "📌",
            lazy = "💤 ",
        },
    },
})

-- Function to check if a file exists
local function file_exists(file)
    local f = io.open(file, "r")
    if f then
        f:close()
        return true
    else
        return false
    end
end

-- Path to the session file
local session_file = ".session.vim"

-- Check if the session file exists in the current directory
if file_exists(session_file) then
    -- Source the session file
    vim.cmd("source " .. session_file)
end
