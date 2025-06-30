local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  s("log", {
    t("console.log("), i(1, "msg"), t(")")
  }),
  s("func", {
    t("function "), i(1, "name"), t("("), i(2), t({") {", "\t"}), i(3), t({"", "}"})
  }),
}

