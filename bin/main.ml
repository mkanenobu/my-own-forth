open Lib

let () =
  let forth = new Eval.evaluator in
  Readline.readline_loop forth#eval tokens
;;
