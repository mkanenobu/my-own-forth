type stack = float list

let empty () : stack = []
let is_empty (s : stack) : bool = s = []
let push (x : float) (s : stack) : stack = x :: s

let pop (s : stack) : float * stack =
  match s with
  | [] -> failwith "Stack is empty"
  | x :: xs -> x, xs
;;

let peek (s : stack) : float =
  match s with
  | [] -> failwith "Stack is empty"
  | x :: _ -> x
;;
