type word =
  { name : string
  ; func : Stack.stack -> Stack.stack
  }

type dictionaly = word list

let new_dictionaly () : dictionaly =
  [ { name = "+"; func = Builtin.add }
  ; { name = "-"; func = Builtin.sub }
  ; { name = "*"; func = Builtin.mul }
  ; { name = "/"; func = Builtin.div }
  ; { name = "."; func = Builtin.pop_and_print }
  ; { name = ".s"; func = Builtin.print_stack }
  ]
;;

let find_word (dict : dictionaly) (name : string) : word option =
  List.find_opt (fun word -> word.name = name) dict
;;

class evaluator =
  object
    val mutable stack = Stack.empty ()
    val mutable dict = new_dictionaly ()

    method eval (tokens : string list) : unit =
      let eval_token (token : string) =
        let word = find_word dict token in
        match word with
        | Some word -> stack <- word.func stack
        | None ->
          let f = float_of_string token in
          stack <- Stack.push f stack
      in
      List.iter eval_token tokens
  end
