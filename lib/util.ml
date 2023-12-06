let join_string_list (sep : string) (l : string list) : string =
  let rec join' (sep : string) (l : string list) (acc : string) : string =
    match l with
    | [] -> acc
    | [ x ] -> acc ^ x
    | x :: xs -> join' sep xs (acc ^ x ^ sep)
  in
  join' sep l ""
;;

let%expect_test _ =
  join_string_list ", " [ "Hello"; "world!" ] |> print_endline;
  [%expect {|
    Hello, world!
  |}]
;;
