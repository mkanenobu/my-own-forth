let join (l : string list) (sep : string) : string =
  let rec join' (sep : string) (l : string list) (acc : string) : string =
    match l with
    | [] -> acc
    | [ x ] -> acc ^ x
    | x :: xs -> join' sep xs (acc ^ x ^ sep)
  in
  join' sep l ""
;;
