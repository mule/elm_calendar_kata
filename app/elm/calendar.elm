port module Calendar exposing (..)

import Html exposing ( text, div)
import Html.Attributes exposing (class)
import List exposing (concat)
import Html.App as Html
import Html.Events exposing (..)


main : Html.Html a
main =
    Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }

type alias Model =
    { weekdays: List String }

init : (Model, Cmd Msg)

init =
    (Model [], Cmd.none)

type Msg
    = GetWeekdays
    | Weekdays

port weekdaysRequest : Cmd msg

update: Msg -> Model -> (Model, Cmd Msg)

update action model =
    case action of
        getWeekdays ->
            (model, weekdaysRequest)
        weekdays -> (model, dateOperations)

port weekdaysResponse : (List String -> msg) -> Sub msg

subscriptions : Model -> Sub Msg
subsricptions model =
    weekdaysResponse

view : List String -> Html.Html a

view model =
    div [class "row"] (div [class "col s2"] [] ::  weekday_columns model ++ [div [class "col s3"] []])

weekday_columns : List String -> List (Html.Html a)

weekday_columns weekdays =
    List.map  (\n -> div [class "col s1"] [text n]) weekdays
