type word =
  { name : string
  ; func : (Stack.stack -> Stack.stack) option
  ; words : int list option
  }

type dictionaly = word list

let new_dictionaly () : dictionaly =
  [ { name = "+"; func = Some Builtin.add; words = None }
  ; { name = "-"; func = Some Builtin.sub; words = None }
  ; { name = "*"; func = Some Builtin.mul; words = None }
  ; { name = "/"; func = Some Builtin.div; words = None }
  ; { name = "."; func = Some Builtin.pop_and_print; words = None }
  ; { name = ".s"; func = Some Builtin.print_stack; words = None }
  ; { name = "dup"; func = Some Builtin.dup; words = None }
  ; { name = "square"; func = None; words = Some [ 6; 2 ] } (* 6, 2 = dup, * *)
  ]
;;

let find_word (dict : dictionaly) (name : string) : word option =
  List.find_opt (fun word -> word.name = name) dict
;;

class evaluator =
  object (self)
    val mutable stack = Stack.empty ()
    val mutable dict = new_dictionaly ()

    method eval_word (index : int) : Stack.stack =
      let eval_word' (index' : int) : Stack.stack =
        let word = List.nth dict index' in
        match word.func with
        | Some func -> func stack
        | None ->
          (match word.words with
           | Some words ->
             List.iter (fun i -> stack <- self#eval_word i) words;
             stack
           | None -> stack)
      in
      eval_word' index

    method eval (tokens : string list) : unit =
      let eval_token (token : string) =
        let handled = ref false in
        List.iteri
          (fun i word ->
            if word.name = token
            then (
              stack <- self#eval_word i;
              handled := true))
          dict;
        if not !handled
        then (
          let f = float_of_string token in
          stack <- Stack.push f stack)
        else ()
      in
      List.iter eval_token tokens
  end
