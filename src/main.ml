open Util

type msg =
  | Increment
  | Decrement
  | Reset
  | Set of int
  [@@bs.deriving {accessors}]

let init () = 4 <! []

let subscriptions model =
  Tea_sub.none

let update model msg =
  match msg with
  | Increment -> model + 1 <! []
  | Decrement -> model - 1 <! []
  | Reset -> 0 <! []
  | Set v -> v <! []

let view_button title msg =
  let open Tea.Html in
  button
    [ onClick msg
    ]
    [ text title
    ]

let view model =
  let open Tea.Html in
  div
    []
    [ span
        [ style "text-weight" "bold" ]
        [ text (string_of_int model) ]
    ; br []
    ; view_button "Increment" Increment
    ; br []
    ; view_button "Decrement" Decrement
    ; br []
    ; view_button "Set to 42" (Set 42)
    ; br []
    ; if model <> 0 then view_button "Reset" Reset else noNode
    ]

let main =
  Test_mod.test ();
  let open Tea.App in
  standardProgram {
      init = init;
      update = update;
      view = view;
      subscriptions = subscriptions;
    }
