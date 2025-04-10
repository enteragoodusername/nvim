local vim = vim
local Plug = vim.fn['plug#']
require('fireOpen')
vim.call('plug#begin')
vim.opt.clipboard = "unnamedplus"

Plug('motosir/skel-nvim')
Plug('tpope/vim-sensible')
Plug('sainnhe/everforest')
Plug('rose-pine/neovim',{as = "rose-pine"})
Plug('williamboman/mason.nvim')
Plug('williamboman/mason-lspconfig.nvim')
Plug('ethanholz/nvim-lastplace')
Plug('mfussenegger/nvim-lint')
Plug('folke/trouble.nvim')
Plug('mhartington/formatter.nvim')
Plug('alvan/vim-closetag')
Plug('neovim/nvim-lspconfig')
Plug('hrsh7th/cmp-nvim-lsp')
Plug('hrsh7th/cmp-buffer')
Plug('hrsh7th/cmp-path')
Plug('hrsh7th/cmp-cmdline')
Plug('hrsh7th/nvim-cmp')
Plug('hrsh7th/cmp-vsnip')
Plug('hrsh7th/vim-vsnip')
Plug('folke/lsp-colors.nvim')
Plug('mbbill/undotree')
Plug('windwp/nvim-ts-autotag')
Plug('xiyaowong/transparent.nvim')
vim.opt.clipboard = “unamedplus” 
vim.call('plug#end');

vim.cmd('set autoindent')
vim.cmd("colorscheme rose-pine")
--vim.cmd('colorscheme everforest')
vim.cmd('set background=dark')
vim.cmd('set undofile')
vim.cmd([[let mapleader=","]])
vim.cmd('set number relativenumber')
vim.cmd('set nu rnu')
vim.cmd('set pumheight=8')
vim.g.closetag_filenames = '*.html,*.xhtml,*.phtml'
require("mason").setup()
require("mason-lspconfig").setup()
require("mason-lspconfig").setup_handlers {
	function (server_name) -- default handler (optional)
	    require("lspconfig")[server_name].setup {
		
		settings = {
			Lua = {
				diagnostics = {
					globals = {'vim'}
				}

			}		}
	    }
	end
}
local capabilities = vim.lsp.protocol.make_client_capabilities()
local lspconfig = require('lspconfig')
lspconfig.gdscript.setup(capabilities)



lspconfig.rust_analyzer.setup({
    on_attach = on_attach,
    settings = {
        ["rust-analyzer"] = {
            imports = {
                granularity = {
                    group = "module",
                },
                prefix = "self",
            },
            cargo = {
                buildScripts = {
                    enable = true,
                },
            },
            procMacro = {
                enable = true
            },
        }
    }
})
vim.diagnostic.config({
  virtual_text = true,
})
 -- Optional, you don't have to run setup.
require("transparent").setup({
  -- table: default groups
  groups = {
    'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
    'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
    'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
    'SignColumn', 'CursorLine', 'CursorLineNr', 'StatusLine', 'StatusLineNC',
    'EndOfBuffer',
  },
  -- table: additional groups that should be cleared
  extra_groups = {},
  -- table: groups you don't want to clear
  exclude_groups = {},
  -- function: code to be executed after highlight groups are cleared
  -- Also the user event "TransparentClear" will be triggered
  on_clear = function() end,
})
require'cmp'.setup {
  sources = {
    { name = 'nvim_lsp' }
  }
}
require"trouble".setup{
	  cmd = "Trouble",
	  opts = {},
   
    
}
vim.opt.backup = false
vim.opt.swapfile = false
if vim.loop.os_uname().sysname == "Windows_NT" then
	vim.opt.undodir = './.undodir'
	vim.g.undotree_DiffCommand = "FC"
end

vim.opt.undofile = true





-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- An example for configuring `clangd` LSP to use nvim-cmp as a completion engine 
require'nvim-lastplace'.setup{}
local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
      end,
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })
  -- removes highlight from the border, this would make the border opaque, now its transparent!
	vim.api.nvim_set_hl(0,"FloatBorder", {bg = "NONE", blend =100})
  -- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
  -- Set configuration for specific filetype.
  --[[ cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'git' },
    }, {
      { name = 'buffer' },
    })
 })
 require("cmp_git").setup() ]]-- 

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    }),
    matching = { disallow_symbol_nonprefix_matching = false }
  })


require("skel-nvim").setup{
  -- file pattern -> template mappings
  mappings = {
    ['*.html']   = "html.skel",
	}
}
