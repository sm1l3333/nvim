local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
	return
end

local config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
if not config_status_ok then
	return
end

local keymap_status_ok, keymap = pcall(require, "nvim-tree.keymap")
if not keymap_status_ok then
	return
end

local api_status_ok, api = pcall(require, "nvim-tree.api")
if not api_status_ok then
	return
end
on_attach = function(bufnr) 
		local function opts(desc)
			return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
		end

		keymap.default_on_attach()

		vim.keymap.set('n', 'l', api.node.open.edit, opts('Open'))
		vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Open'))
		vim.keymap.set('n', 'o', api.node.open.edit, opts('Open'))
		vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts('Close Directory'))
		vim.keymap.set('n', 'v', api.node.open.vertical, opts('Open: Vertical Split')) 
end

nvim_tree.setup({
	disable_netrw = true,
	on_attach = on_attach,
	sort_by = "case_sensitive", -- sort by name
	hijack_netrw = true,
	filters = { custom = { ".git", ".expo", "node_modules", "vendor" },
		dotfiles = false,
		exclude = { ".gitignore" },
	},
	hijack_cursor = false,
	update_cwd = true,
	hijack_directories = {
		enable = true,
	},
	-- --   error
	-- --   info
	-- --   question
	-- --   warning
	-- --   lightbulb
	renderer = {
		add_trailing = false,
		group_empty = false,
		highlight_git = true,
		highlight_opened_files = "none",
		root_folder_modifier = ":t",
		indent_markers = {
			enable = false,
			icons = {
				corner = "└ ",
				edge = "│ ",
				none = "  ",
			},
		},
		icons = {
			webdev_colors = true,
			git_placement = "before",
			padding = " ",
			symlink_arrow = " ➛ ",
			show = {
				file = true,
				folder = true,
				folder_arrow = true,
				git = true, -- shwo icons in files
			},
			glyphs = {
				default = "",
				symlink = "",
				folder = {
					arrow_open = "",
					arrow_closed = "",
					default = "",
					open = "",
					empty = "",
					empty_open = "",
					symlink = "",
					symlink_open = "",
				},
				git = {
					unstaged = "",
					staged = "S",
					unmerged = "",
					renamed = "➜",
					untracked = "U",
					deleted = "",
					ignored = "◌",
				},
			},
		},
	},
	diagnostics = {
		enable = false, -- disable diagnostics in files
		icons = {
			hint = "",
			info = "",
			warning = "",
			error = "",
		},
	},
	update_focused_file = {
		enable = true,
		update_cwd = true,
		ignore_list = {},
	},
	git = {
		enable = true,
		ignore = false,
		timeout = 500,
	},
	view = {
		width = 50,
		hide_root_folder = false,
		side = "left",
		number = true,
		relativenumber = true,
	},
})
