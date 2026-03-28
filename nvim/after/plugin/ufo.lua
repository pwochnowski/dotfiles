
local ufo = require('ufo')
--vim.o.fillchars = [[eob: ,fold: ,foldopen:▾,foldsep: ,foldclose:▸]]
vim.o.foldcolumn = "0" -- 10 breaks the plugin, 9 works with the issue mentioned before
vim.o.foldnestmax = 1
vim.o.foldlevel = 99999999 -- Bigger than this also breaks the plugin
vim.o.foldlevelstart = 99999999
vim.o.foldenable = true

-- vim.o.scrolloff = 5
-- vim.o.sidescrolloff = 5

-- Redrawing and cursor enhancements
vim.o.lazyredraw = false
-- vim.o.cursorline = true
-- vim.o.cursorcolumn = true
-- vim.o.cursorlineopt = "number,line"

-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
vim.keymap.set('n', 'zR', ufo.openAllFolds)
vim.keymap.set('n', 'zM', ufo.closeAllFolds)

vim.fn.sign_define("FoldClosed", { text = "▸", texthl = "Folded" })
vim.fn.sign_define("FoldOpen", { text = "▾", texthl = "Folded" })
vim.fn.sign_define("FoldSeparator", { text = " ", texthl = "Folded" })

--hi! UfoFoldedFg guifg=NONE
--hi! UfoFoldedBg guibg=FoldedBg
--vim.api.nvim_set_hl(0, "UfoFoldedFg", { link = "Normal" })


local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
}
local language_servers = vim.lsp.get_clients() -- or list servers manually like {'gopls', 'clangd'}
for _, ls in ipairs(language_servers) do
    require('lspconfig')[ls].setup({
        capabilities = capabilities
        -- you can add other fields for setting up lsp server in this table
    })
end
local handler = function(virtText, lnum, endLnum, width, truncate)
  local newVirtText = {}
  local totalLines = vim.api.nvim_buf_line_count(0)
  local foldedLines = endLnum - lnum
  local suffix = ("  %d"):format(foldedLines)
  if foldedLines / totalLines * 100 > 10 then
    suffix = suffix .. (" lines - %d%%"):format(foldedLines / totalLines * 100)
  end
  local sufWidth = vim.fn.strdisplaywidth(suffix)
  local targetWidth = width - sufWidth
  local curWidth = 0
  for _, chunk in ipairs(virtText) do
    local chunkText = chunk[1]
    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
    if targetWidth > curWidth + chunkWidth then
      table.insert(newVirtText, chunk)
    else
      chunkText = truncate(chunkText, targetWidth - curWidth)
      local hlGroup = chunk[2]
      table.insert(newVirtText, { chunkText, hlGroup })
      chunkWidth = vim.fn.strdisplaywidth(chunkText)
      if curWidth + chunkWidth < targetWidth then
        suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
      end
      break
    end
    curWidth = curWidth + chunkWidth
  end
  local rAlignAppndx = math.max(math.min(vim.opt.textwidth["_value"], width - 1) - curWidth - sufWidth, 0)
  suffix = (" "):rep(rAlignAppndx) .. suffix
  --local lastHl = virtText[#virtText] and virtText[#virtText][2] or nil
  --print(lastHl)
  table.insert(newVirtText, { suffix, nil })
  return newVirtText
end

require("ufo").setup({
  fold_virt_text_handler = handler
})


