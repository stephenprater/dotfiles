[[; Jinja Injection within HTMLA
([
  (attribute_value)
  (attribute)
  (text)
  ] @injection.content
  (#match? @injection.content "({{|{%).*?(%}|}})")
  (#set! injection.language "jinja")
)]]
