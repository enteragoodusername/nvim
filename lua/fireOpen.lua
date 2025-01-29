vim.api.nvim_create_user_command('FireOpen', function()

	vim.api.nvim_create_autocmd("ExitPre", {
	pattern = "<buffer>",
	  callback = function()
		vim.cmd([[silent! %s/<!--<img/<img]])
		vim.cmd([[silent! %s/\v(<!--)@<!--\>/]])
		vim.cmd([[silent! %s/<script>.*<\/script>/]])
		vim.cmd("write")
	  end
	});
	vim.cmd([[%s/<img.*>/<!--&-->/g]])
	vim.cmd([[%s/<!DOCTYPE.*>/&\r<script>setTimeout(function () {location.reload();}, 500);<\/script>]])
	local job = vim.fn.jobstart('firefox -new-window '.. vim.api.nvim_buf_get_name(0),
	{
		on_stdout = function() end
	})

end, { desc = 'Opens current file in firefox browser' })

