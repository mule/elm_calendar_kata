import Html exposing (Html, text, div)
import Html.Attributes exposing (class)
import List exposing (concat)

main : Html.Html a
main =
    view  model

model : List String

model = ["Ma", "Ti", "Ke", "To", "Pe", "La", "Su"]

view : List String -> Html a

-- view model =
--     let col s =
--          div [class "col s1"] [ text s]
--     in
--         div [class "row"] (List.map col model)

view model =
    div [class "row"] (div [class "col s2"] [] ::  weekday_columns model ++ [div [class "col s3"] []])


weekday_columns : List String -> List (Html a)

weekday_columns weekdays =
    List.map  (\n -> div [class "col s1"] [text n]) weekdays
