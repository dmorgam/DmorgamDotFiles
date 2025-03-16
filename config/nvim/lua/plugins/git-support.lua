-- Git support

return {
    {
        'lewis6991/gitsigns.nvim',
        config = function ()
            require('gitsigns').setup()
        end
    },
    {"NeogitOrg/neogit",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "sindrets/diffview.nvim",
        "nvim-telescope/telescope.nvim",
    },
    config = function ()

        require('neogit').setup({
            kind = 'split',
            graph_style = 'unicode'
        })

        -- Funcion que hace toggle al split de neogit
        vim.api.nvim_create_user_command("NeoGitToggleSplit", function ()
            local win_exists = false

            for _, win in ipairs(vim.api.nvim_list_wins()) do
                local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(win))
                if bufname:match("NeogitStatus") then
                    vim.api.nvim_win_close(win, true)
                    win_exists = true
                    break
                end
            end

            if not win_exists then
                vim.cmd("Neogit")
            end

        end, {desc = "Toggle neogit split"})

    end
    },
}
