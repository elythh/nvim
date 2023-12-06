local colors = require("prism.themer"):getColors()

return {
  Identifier = { fg = colors.color4 },
  LineNr = { fg = colors.comment }
}
