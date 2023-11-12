return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "typescript", "tsx" })
      end

      local parser_config =
        require("nvim-treesitter.parsers").get_parser_configs()
      parser_config.tsx.filetype_to_parsername =
        { "javascript", "typescript.tsx", "javascriptreact" }
    end,
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        denols = {
          root_dir = require("lspconfig").util.root_pattern(
            "deno.json",
            "deno.jsonc"
          ),
        },
        tsserver = {
          root_dir = require("lspconfig").util.root_pattern(
            "package.json",
            "tsconfig.json",
            "jsconfig.json"
          ),
        },
      },
    },
  },

  {
    "nvimtools/none-ls.nvim",
    optional = true,
    opts = function(_, opts)
      local nls = require("null-ls")
      local eslint_config_files = {
        ".eslintrc.js",
        ".eslintrc.cjs",
        ".eslintrc.yaml",
        ".eslintrc.yml",
        ".eslintrc.json",
      }

      opts.sources = opts.sources or {}

      vim.list_extend(opts.sources, {
        nls.builtins.code_actions.eslint_d.with({
          condition = function(utils)
            return utils.root_has_file(eslint_config_files)
          end,
        }),
        nls.builtins.formatting.eslint_d.with({
          condition = function(utils)
            return utils.root_has_file(eslint_config_files)
          end,
        }),
        nls.builtins.diagnostics.eslint_d.with({
          condition = function(utils)
            return utils.root_has_file(eslint_config_files)
          end,
        }),

        nls.builtins.formatting.prettierd.with({
          filetypes = { "typescript" },
          condition = function(utils)
            return not utils.root_has_file(eslint_config_files)
          end,
        }),
      })
    end,
  },
}