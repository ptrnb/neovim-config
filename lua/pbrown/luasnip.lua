local snip_status_ok, ls = pcall(require, "luasnip")
if not snip_status_ok then
	return
end

local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require("luasnip.util.types")
local conds = require("luasnip.extras.expand_conditions")

local newline = function(text)
	return t({ "", text })
end

local require_var = function(args, _)
	local text = args[1][1] or ""
	local split = vim.split(text, ".", { plain = true })

	local options = {}
	for len = 0, #split - 1 do
		table.insert(options, t(table.concat(vim.list_slice(split, #split - len, #split), "_")))
	end

	return sn(nil, {
		c(1, options),
	})
end

-- Load snippets

-- LUA style
ls.snippets = {
	all = {
		s("ternary", {
			-- equivalent to "${1:cond} ? ${2:then} : ${3:else}"
			i(1, "cond"),
			t(" ? "),
			i(2, "then"),
			t(" : "),
			i(3, "else"),
		}),
	},
	rust = {
		s("allu", {
			t({ "#![allow(unused)] // Silence unused warnings during development (to comment out)", "" }),
		}),
	},
}

-- Snipmate style
require("luasnip.loaders.from_snipmate").lazy_load()

-- VSCode style
require("luasnip.loaders.from_vscode").lazy_load()
