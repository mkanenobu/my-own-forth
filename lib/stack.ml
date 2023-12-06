type stack = float list

let empty () : stack = []
let is_empty (s : stack) : bool = s = []
let push (x : float) (s : stack) : stack = x :: s

let pop (s : stack) : float option * stack =
  match s with
  | [] -> None, s
  | x :: xs -> Some x, xs
;;
