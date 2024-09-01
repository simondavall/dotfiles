-- how to add custom snippets https://www.youtube.com/watch?v=FmHhonPjvvA

local luasnip = require("luasnip")
local s = luasnip.snippet
local t = luasnip.text_node
local i = luasnip.insert_node
local fmt = require("luasnip.extras.fmt").fmt

M = {}

function M.load()

  luasnip.add_snippets("c",{
    s("main_sdv", fmt(
      [[
      #include <stdio.h>
      #include <stdlib.h>

      int main(void){{

        printf("{}\n");

        return EXIT_SUCCESS;
      }}
      ]], {
        i(0)
      })),
    s("main_read", fmt(
      [[
      #include <stdio.h>
      #define MAX_LEN 20

      int read_line(char str[], int n);

      int main(void){{
        char str[MAX_LEN + 1];

        printf("Enter filename: ");
        int n = read_line(str, MAX_LEN);
        {}

        return 0;
      }}

      int read_line(char str[], int n){{
        int ch, i = 0;

        while ((ch = getchar()) != '\n' && i < n)
          str[i++] = ch;
        str[i] = '\0';
        return i;
      }}
      ]], {
        i(0)
      }))
    })

end

return M

