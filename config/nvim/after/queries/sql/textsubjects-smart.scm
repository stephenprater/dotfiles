;extends
(([
  (program)
  (statement)
  (cte)
  (select_expression)
  (term)
  (window_function)
  (from)
  (where)
  (join)
  (order_by)
  (group_by)
] @_start @_end)
(#make-range! "range" @_start @_end)
)
