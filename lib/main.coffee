$ = require("atom").$
module.exports = activate: (state) ->
  applyBorder = ->
    # HEX and RGB values
    atom.workspaceView.find(".css.color, .rgb-value, .w3c-standard-color-name").each (i, el) ->
      type = $(this).prevAll(".support.function").text()
      if type is "rgb" or type is "rgba"
        $(this)[0].style["border-bottom"] = "1px solid " + type + "(" + el.innerText + ")"
      else
        $(this)[0].style["border-bottom"] = "1px solid " + el.innerText
    # HSL values
    atom.workspaceView.find(".meta.property-value.css").each (i, el) ->
      type = $(this).find(".support.function, .misc.css").text()
      cache = $(this).find(".numeric.css")
      if type is "hsl" or type is "hsla"
        values = ""
        hslValues = cache.each ->
          values += $(this).text() + ","
        if values.length
          values = values.slice(0, values.length - 1)
          cache.each ->
            $(this)[0].style["border-bottom"] = "1px solid " + type + "(" + values + ")"
    # LESS values
    atom.workspaceView.find(".less").each ->
      type = $(this).find(".builtin").text()
      cache = $(this).find(".numeric.css")
      if type is "rgb" or type is "rgba"
        values = ""
        rgbValues = cache.each ->
          values += $(this).text() + ","
        if values.length
          values = values.slice(0, values.length - 1)
          cache.each ->
            $(this)[0].style["border-bottom"] = "1px solid " + type + "(" + values + ")"
  # Apply borders to views
  atom.workspaceView.eachEditorView (editorView) ->
    editorView.on "editor:display-updated", applyBorder
