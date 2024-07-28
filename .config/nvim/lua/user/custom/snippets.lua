local luasnip = require("luasnip")
local s = luasnip.snippet
local t = luasnip.text_node
local i = luasnip.insert_node

M = {}

function M.load()

  luasnip.add_snippets("c", {
    s("main_sdv", {
      t("#include <stdio.h>"),
      t({"", ""}),
      t({"", "int main(void){"}),
      t({"", "\t"}), i(0),
      t({"", "\tprintf(\"Answer:\\n\");"}),
      t({"", "\treturn 0;"}),
      t({"", "}"}),
    })
  })

end

return M

