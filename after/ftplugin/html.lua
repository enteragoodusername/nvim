local vim = vim 
vim.cmd('setlocal spell spelllang=en_us')
vim.api.nvim_create_autocmd({'TextChanged','TextChangedI'},{
	pattern = "<buffer>",
	callback = function (opts)
		vim.cmd("silent write")
	end,
})


