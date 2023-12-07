let print_stack_underflow_error () : unit = Printf.printf "Error: stack underflow\n"

let add (stack : Stack.stack) : Stack.stack =
  let a, stack' = Stack.pop stack in
  let b, stack' = Stack.pop stack' in
  match a, b with
  | Some a, Some b -> Stack.push (a +. b) stack'
  | _ ->
    print_stack_underflow_error ();
    stack
;;

let sub (stack : Stack.stack) : Stack.stack =
  let a, stack' = Stack.pop stack in
  let b, stack' = Stack.pop stack' in
  match a, b with
  | Some a, Some b -> Stack.push (a -. b) stack'
  | _ ->
    print_stack_underflow_error ();
    stack
;;

let mul (stack : Stack.stack) : Stack.stack =
  let a, stack' = Stack.pop stack in
  let b, stack' = Stack.pop stack' in
  match a, b with
  | Some a, Some b -> Stack.push (a *. b) stack'
  | _ ->
    print_stack_underflow_error ();
    stack
;;

let div (stack : Stack.stack) : Stack.stack =
  let a, stack' = Stack.pop stack in
  let b, stack' = Stack.pop stack' in
  match a, b with
  | Some a, Some b -> Stack.push (a /. b) stack'
  | _ ->
    print_stack_underflow_error ();
    stack
;;

let pop_and_print (stack : Stack.stack) : Stack.stack =
  let a, stack' = Stack.pop stack in
  match a with
  | Some a ->
    Printf.printf "%F\n" a;
    stack'
  | None ->
    print_stack_underflow_error ();
    stack
;;

let print_stack (stack : Stack.stack) : Stack.stack =
  print_string "[";
  List.rev stack
  |> List.map (fun el -> Printf.sprintf "%F" el)
  |> Util.join_string_list "; "
  |> print_string;
  print_string "]";
  print_endline "";
  stack
;;

let dup (stack : Stack.stack) : Stack.stack =
  let a, stack = Stack.pop stack in
  match a with
  | None ->
    print_stack_underflow_error ();
    stack
  | Some a -> Stack.push a (Stack.push a stack)
;;

let emit (stack : Stack.stack) : Stack.stack =
  let a, stack = Stack.pop stack in
  match a with
  | Some a ->
    print_char (char_of_int (int_of_float a));
    stack
  | None ->
    print_stack_underflow_error ();
    stack
;;

let do' (stack : Stack.stack) : Stack.stack =
  (* nop *)
  stack
;;

let loop (stack : Stack.stack) : Stack.stack =
  let cur, stack' = Stack.pop stack in
  let max, stack' = Stack.pop stack' in
  match cur, max with
  | Some cur, Some max -> Stack.push max stack' |> Stack.push (cur +. 1.0)
  | _ ->
    print_stack_underflow_error ();
    stack
;;
