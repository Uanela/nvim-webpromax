;; Function call outer includes the whole call expression (func name + args)
(call_expression) @call.outer

;; Inner is just the arguments inside parentheses
(call_expression
  arguments: (arguments) @call.inner)

