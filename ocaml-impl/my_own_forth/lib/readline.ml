let rec readline_loop (evaluator : string list -> unit) =
  Printf.printf "> ";
  flush stdout;
  let line = String.trim (input_line stdin) in
  if line = "exit"
  then print_endline "Goodbye!"
  else (
    let tokens = String.split_on_char ' ' line in
    evaluator tokens;
    readline_loop evaluator)
;;
