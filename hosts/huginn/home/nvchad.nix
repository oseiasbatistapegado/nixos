{ pkgs, unstable, ... }:
{
  programs.nvchad = {
    enable = true;
    neovim = unstable.neovim-unwrapped;

    extraPlugins = ''
      local function get_secret(path)
        local file = io.open(path, "r")

        if not file then return nil end

        local content = file:read("*a"):gsub("%s+", "")
        file:close()

        return content
      end

      local gemini_key_path = os.getenv("HOME") .. "/.config/gemini_key"

      return {
        {
          "yetone/avante.nvim",
          event = "VeryLazy",
          lazy = false,
          version = false,
          build = "make",
          opts = {
            provider = "gemini",
            providers = {
              gemini = {
                api_key = get_secret(gemini_key_path) or "KEY NOT FOUND",
                model = "gemini-flash-lite-latest",
                temperature = 1,
                max_tokens = 4096,
              },
            },
          },
          dependencies = {
            "stevearc/dressing.nvim",
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "hrsh7th/nvim-cmp",
            "nvim-tree/nvim-web-devicons",
            "HakonHarnes/img-clip.nvim",
            "MeanderingProgrammer/render-markdown.nvim",
          },
        },
        -- Configuração do LSP
        {
          "neovim/nvim-lspconfig",
          config = function()

            local ok, nv_lsp = pcall(require, "nvchad.configs.lspconfig")
            local opts = {}

            if ok then
              opts.on_attach = nv_lsp.on_attach
              opts.capabilities = nv_lsp.capabilities
            end

            vim.lsp.config("gopls", {
              settings = {
                gopls = {
                  analyses = { unusedparams = true },
                  staticcheck = true,
                },
              },
            })

            vim.lsp.config("ts_ls", {})

            vim.lsp.enable({ "gopls", "ts_ls", "zls" })

            vim.filetype.add({
              filename = {
                ["go.work"] = "gowork",
              },
              extension = {
                tmpl = "gotmpl",
              },
            })

          end,
        },
        {
          "tpope/vim-dadbod",
          lazy = true,
        },
        {
          "hrsh7th/nvim-cmp",
          opts = function(_, opts)
            -- Adiciona a fonte do Dadbod à lista de fontes do nvim-cmp
            opts.sources = opts.sources or {}
            table.insert(opts.sources, { name = "vim-dadbod-completion" })
          end,
        },

        {
          "kristijanhusak/vim-dadbod-ui",
          dependencies = {
            { "tpope/vim-dadbod", lazy = true },
            { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
          },
          cmd = {
            "DBUI",
            "DBUIToggle",
            "DBUIAddConnection",
            "DBUIFindBuffer",
          },
          init = function()
            vim.g.db_ui_use_nerd_fonts = 1
            vim.g.db_ui_show_database_icon = 1
            
            -- Opcional: Auto-completar automático ao abrir SQL
            vim.api.nvim_create_autocmd("FileType", {
              pattern = { "sql", "mysql", "plsql" },
              callback = function()
                require("cmp").setup.buffer {
                  sources = {
                    { name = "vim-dadbod-completion" },
                    { name = "buffer" },
                  },
                }
              end,
            })
          end,
        },
        {
          "kdheepak/lazygit.nvim",
          cmd = { "LazyGit", "LazyGitConfig", "LazyGitCurrentFile" },
          dependencies = { "nvim-lua/plenary.nvim" },
        },
        {
          "mistweaverco/kulala.nvim",
          keys = {
            { "<leader>Rs", desc = "Send request" },
            { "<leader>Ra", desc = "Send all requests" },
            { "<leader>Rb", desc = "Open scratchpad" },
          },
          ft = {"http", "rest"},
          opts = {
            global_keymaps = true,
            global_keymaps_prefix = "<leader>R",
            kulala_keymaps_prefix = "",
          },
        },
      }
    '';
 
    chadrcConfig = ''
      local M = {}

      M.base46 = {
        theme = "neofusion", -- Definimos o tema base aqui
        transparency = true,
        theme_reload = true,
        changed_themes = {
          chadsidian = {
            base00 = "#111e2a", -- Background Rapture
            base01 = "#1a2a3a", 
            base02 = "#304b66", 
            base03 = "#304b66", 
            base04 = "#c0c9e5", 
            base05 = "#c0c9e5", -- Foreground Rapture
            base06 = "#ffffff", 
            base07 = "#ffffff", 
            base08 = "#fc644d", -- Vermelho
            base09 = "#fc644d", 
            base0A = "#fff09b", -- Amarelo
            base0B = "#7afde1", -- Verde
            base0C = "#64e0ff", -- Ciano
            base0D = "#6c9bf5", -- Azul
            base0E = "#ff4fa1", -- Rosa
            base0F = "#ff4fa1", 
          }
        },
        hl_override = {
          Comment = { fg = "#304b66" },
          ["@comment"] = { fg = "#304b66" },
          ["@keyword"] = { fg = "#ff4fa1" },
          ["@function"] = { fg = "#6c9bf5" },
          ["@variable"] = { fg = "#c0c9e5" },
        },
      }

      M.ui = {
        theme = "chadtain",
        transparency = true,
      }

      -- Mapeamentos usando a API recomendada pela doc que você mandou
      local map = vim.keymap.set

      -- Atalho para o LazyGit
      map("n", "<leader>gg", "<cmd>LazyGit<CR>", { desc = "Git: Abrir LazyGit" })

      return M
    '';
  };
}
