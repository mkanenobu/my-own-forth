type word =
  { name : string
  ; func : (Stack.stack -> Stack.stack) option
  ; words : int list option
  }

type dictionaly = word list

let find_word (dict : dictionaly) (name : string) : word option =
  List.find_opt (fun word -> word.name = name) dict
;;

let find_word_index (dict : dictionaly) (name : string) : int option =
  List.find_index (fun w -> w.name = name) dict
;;

class evaluator =
  object (self)
    val mutable stack = Stack.empty
    val mutable dict : dictionaly = []
    val mutable compiling = false
    val mutable tmp_word : word option = None
    initializer dict <- self#new_dictionaly ()
    method start_compiling () : unit = compiling <- true

    method new_dictionaly () : dictionaly =
      [ { name = "+"; func = Some Builtin.add; words = None }
      ; { name = "-"; func = Some Builtin.sub; words = None }
      ; { name = "*"; func = Some Builtin.mul; words = None }
      ; { name = "/"; func = Some Builtin.div; words = None }
      ; { name = "."; func = Some Builtin.pop_and_print; words = None }
      ; { name = ".s"; func = Some Builtin.print_stack; words = None }
      ; { name = "dup"; func = Some Builtin.dup; words = None }
      ; { name = ":"
        ; func =
            Some
              (fun stack' ->
                self#start_compiling ();
                stack')
        ; words = None
        }
      ]

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
        let token = String.trim token in
        if String.length token = 0
        then ()
        else if compiling (* compile mode *)
        then (
          match tmp_word with
          | None ->
            (* check duplicate *)
            let exists = find_word dict token in
            if Option.is_some exists
            then Printf.eprintf "word %s is already defined.\n" token
            else tmp_word <- Some { name = token; func = None; words = None }
          | Some _ ->
            if token = ";" (* end of word definition *)
            then (
              (match tmp_word with
               | Some tmp_word' -> dict <- dict @ [ tmp_word' ]
               | None -> ());
              tmp_word <- None;
              compiling <- false)
            else (
              (* word definition *)
              let idx = find_word_index dict token in
              match idx with
              | Some idx' ->
                let tmp_word' = Option.get tmp_word in
                let tmp_word_words = Option.value tmp_word'.words ~default:[] in
                tmp_word
                <- Some { tmp_word' with words = Some (tmp_word_words @ [ idx' ]) }
              | None -> ()))
        else (
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
          else ())
      in
      List.iter eval_token tokens
  end
