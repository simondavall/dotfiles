-- how to add custom snippets https://www.youtube.com/watch?v=FmHhonPjvvA

local luasnip = require("luasnip")
local s = luasnip.snippet
local t = luasnip.text_node
local i = luasnip.insert_node
local fmt = require("luasnip.extras.fmt").fmt

M = {}

function M.load()

  luasnip.add_snippets("c", {
    s("main_sdv", fmt(
      [[
      #include <stdio.h>

      int main(void){{
        {}

        printf("Answer\n");
        return 0;
      }}
      ]], {
        i(0)
      }))
  })

end

return M

