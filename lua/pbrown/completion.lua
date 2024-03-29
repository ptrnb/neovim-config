local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
	return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
	return
end

-- require("luasnip.loaders.from_vscode").lazy_load()

local check_backspace = function()
	local col = vim.fn.col(".") - 1
	return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

local kind_icons = {
	-- Text = "ť",
	-- Method = "m",
	-- Function = "∫",
	-- Constructor = "",
	-- Field = "",
	-- Variable = "",
	-- Class = "",
	-- Interface = "",
	-- Module = "",
	-- Property = "",
	-- Unit = "",
	-- Value = "",
	-- Enum = "",
	-- Keyword = "",
	-- Snippet = "",
	-- Color = "",
	-- File = "",
	-- Reference = "",
	-- Folder = "",
	-- EnumMember = "",
	-- Constant = "",
	-- Struct = "",
	-- Event = "",
	-- Operator = "",
	-- TypeParameter = "",
	Text = "",
	Method = "m",
	Function = "",
	Constructor = "",
	Field = "",
	Variable = "",
	Class = "",
	Interface = "",
	Module = "",
	Property = "",
	Unit = "",
	Value = "",
	Enum = "",
	Keyword = "",
	Snippet = "",
	Color = "",
	File = "",
	Reference = "",
	Folder = "",
	EnumMember = "",
	Constant = "",
	Struct = "",
	Event = "",
	Operator = "",
	TypeParameter = "",
}
-- find more here: https://www.nerdfonts.com/cheat-sheet

cmp.setup({
  preselect = 'none',
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body) -- For `luasnip` users.
		end,
	},
	mapping = {
		["<C-k>"] = cmp.mapping.select_prev_item(),
		["<C-j>"] = cmp.mapping.select_next_item(),
		["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
		["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
		["<C-space>"] = cmp.mapping({
			i = cmp.mapping.complete(),
			c = function(
				_ --[[fallback]]
			)
				if cmp.visible() then
					if not cmp.confirm({ select = true }) then
						return
					end
				else
					cmp.complete()
				end
			end,
		}),
		-- ["<tab>"] = cmp.config.disable,
		["<C-e>"] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		-- Accept currently selected item. If none selected, `select` first item.
		-- Set `select` to `false` to only confirm explicitly selected items.
		-- ["<CR>"] = cmp.mapping.confirm { select = true },
		-- ["<CR>"] = cmp.mapping.confirm { select = false },
		["<C-y>"] = cmp.mapping.confirm({
			behaviour = cmp.ConfirmBehavior.Replace,
			select = true,
		}),

		--   If you want TAB completion use this
		--   ["<Tab>"] = cmp.mapping(function(fallback)
		--     if cmp.visible() then
		--       cmp.select_next_item()
		--     elseif luasnip.expandable() then
		--       luasnip.expand()
		--     elseif luasnip.expand_or_jumpable() then
		--       luasnip.expand_or_jump()
		--     elseif check_backspace() then
		--       fallback()
		--     else
		--       fallback()
		--     end
		--   end, {
		--     "i",
		--     "s",
		--   }),
		--   ["<S-Tab>"] = cmp.mapping(function(fallback)
		--     if cmp.visible() then
		--       cmp.select_prev_item()
		--     elseif luasnip.jumpable(-1) then
		--       luasnip.jump(-1)
		--     else
		--       fallback()
		--     end
		--   end, {
		--     "i",
		--     "s",
		--   }),
		["<Tab>"] = cmp.mapping(function(fallback)
			if luasnip.expandable() then
				luasnip.expand()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif check_backspace() then
				fallback()
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
	}, -- End of mapping
	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = function(entry, vim_item)
			-- Kind icons
			vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
			-- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
			vim_item.menu = ({
				nvim_lsp = "[LSP]",
				nvim_lua = "[Lua]",
				luasnip = "[Snip]",
				buffer = "[Buffer]",
				path = "[Path]",
			})[entry.source.name]
			return vim_item
		end,
	},
	sources = {
		{ name = "luasnip" },
		{ name = "nvim_lua", keyword_length = 3 },
		{ name = "nvim_lsp", keyword_length = 3 },
		{ name = "buffer", keyword_length = 2 },
		{ name = "path", keyword_length = 2 },
	},
	sorting = {
		comparators = {
			cmp.config.compare.offset,
			cmp.config.compare.exact,
			cmp.config.compare.score,
			cmp.config.compare.kind,
			cmp.config.compare.sort_text,
			cmp.config.compare.length,
			cmp.config.compare.order,
		},
	},
	-- confirm_opts = {
	--   behavior = cmp.ConfirmBehavior.Replace,
	--   select = false,
	-- },
  window = {
	  documentation = cmp.config.window.bordered()
	},
	experimental = {
		ghost_text = false,
		native_menu = false,
	},
})

cmp.setup.filetype("gitcommit", {
	sources = cmp.config.sources({
		{ name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it.
	}, {
		{ name = "buffer" },
	}),
})

cmp.setup.filetype({ "markdown", "help" }, {
	sources = {
		{ name = "buffer" },
		{ name = "path" },
	},
})
