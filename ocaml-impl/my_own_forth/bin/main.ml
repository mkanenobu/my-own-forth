open Lib

let () =
  let s = Stack.empty () in
  let s = Stack.push 3.14 s in
  let s = Stack.push 2.71 s in
  let top, s = Stack.pop s in
  let _ = Builtin.print_stack s in
  Printf.printf "Popped: %f\n" top;
  (* 2.71 を出力 *)
  let top = Stack.peek s in
  Printf.printf "Peeked: %f\n" top;
  Readline.readline_loop (fun tokens ->
    List.iter (fun token -> Printf.printf "%s\n" token) tokens)
;;
