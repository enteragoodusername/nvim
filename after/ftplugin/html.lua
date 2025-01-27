local vim = vim 

vim.api.nvim_create_autocmd({'TextChanged','TextChangedI'},{
	pattern = "<buffer>",
	callback = function (opts)
		vim.cmd("silent write")
	end,
})


