port module Calendar exposing (..)

import Html exposing ( text, div, Attribute)
import Html.Attributes exposing (class, classList)
import List exposing (concat)
import Html.App as Html
-- import Html.Events exposing (..)
import Debug
--import Task


main : Program { weekdays : List String }
main =
    Html.programWithFlags
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }
type alias Flags = { weekdays : (List String)}
type alias Model =
    { weekdays: (List String)
    }

init : Flags -> (Model, Cmd Msg)

init flags =
    Debug.log "init running"
    (Model flags.weekdays, Cmd.none )

type Msg
    = GetWeekdays
    | Weekdays (List String)

port weekdaysRequest : String -> Cmd msg

--send : String -> Cmd Msg
--send msg =
  --Task.perform weekdaysRequest weekdaysRequest (Task.succeed msg)

update : Msg -> Model -> (Model, Cmd Msg)

update action model =
    case action of
        GetWeekdays ->
            (model, weekdaysRequest "")
        Weekdays response ->
            Debug.log (toString response)
            (Model response, Cmd.none)

port weekdaysResponse : (List String -> msg) -> Sub msg

subscriptions : Model -> Sub Msg

subscriptions model =
    weekdaysResponse Weekdays

view : Model -> Html.Html Msg

view model =
    Debug.log (toString model)
    div [class "month"] (row [("weekdayRow", True)] (weekday_columns model.weekdays) :: week_rows)


row : List (String, Bool) -> List (Html.Html Msg) -> Html.Html Msg


row classes content  =
    div ( [ classList ([ ("row", True) ] ++ classes) ]) (div [class "col s2"] [] :: content ++ [div [class "col s3"] []])

weekday_columns : List String -> List (Html.Html a)

weekday_columns weekdays =
    List.map  (\n -> div [class "col s1 weekday"] [text n]) weekdays

week_columns : List (Html.Html a)

week_columns =
     List.map (\day -> div [class "col s1 day card-panel teal"] [text (toString day)]) [1..7]

week_rows :  List (Html.Html Msg)
week_rows =
    List.map (\day -> row [("week", True)] week_columns) [1..5]
