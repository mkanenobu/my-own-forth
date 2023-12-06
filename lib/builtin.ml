let add (stack : Stack.stack) : Stack.stack =
  let a, stack = Stack.pop stack in
  match a with
  | None ->
    Printf.eprintf "Error: stack underflow";
    stack
  | Some a ->
    let b, stack = Stack.pop stack in
    (match b with
     | None ->
       Printf.eprintf "Error: stack underflow";
       stack
     | Some b -> Stack.push (a +. b) stack)
;;

let sub (stack : Stack.stack) : Stack.stack =
  let a, stack = Stack.pop stack in
  match a with
  | None ->
    Printf.eprintf "Error: stack underflow";
    stack
  | Some a ->
    let b, stack = Stack.pop stack in
    (match b with
     | None ->
       Printf.eprintf "Error: stack underflow";
       stack
     | Some b -> Stack.push (b -. a) stack)
;;

let mul (stack : Stack.stack) : Stack.stack =
  let a, stack = Stack.pop stack in
  match a with
  | None ->
    Printf.eprintf "Error: stack underflow";
    stack
  | Some a ->
    let b, stack = Stack.pop stack in
    (match b with
     | None ->
       Printf.eprintf "Error: stack underflow";
       stack
     | Some b -> Stack.push (a *. b) stack)
;;

let div (stack : Stack.stack) : Stack.stack =
  let a, stack = Stack.pop stack in
  match a with
  | None ->
    Printf.eprintf "Error: stack underflow";
    stack
  | Some a ->
    let b, stack = Stack.pop stack in
    (match b with
     | None ->
       Printf.eprintf "Error: stack underflow";
       stack
     | Some b -> Stack.push (b /. a) stack)
;;

let pop_and_print (stack : Stack.stack) : Stack.stack =
  let a, stack = Stack.pop stack in
  match a with
  | None ->
    Printf.eprintf "Error: stack underflow";
    stack
  | Some a ->
    Printf.printf "%F\n" a;
    stack
;;

let print_stack (stack : Stack.stack) : Stack.stack =
  Util.join (List.map (fun el -> Printf.sprintf "%F" el) stack) "; " |> print_endline;
  stack
;;