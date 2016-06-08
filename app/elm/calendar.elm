port module Calendar exposing (..)

import Html exposing ( text, div)
import Html.Attributes exposing (class)
import List exposing (concat)
import Html.App as Html
import Html.Events exposing (..)
import Debug
import Task


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
    div [class "row"] (div [class "col s2"] [] ::  weekday_columns model.weekdays ++ [div [class "col s3"] []])

weekday_columns : List String -> List (Html.Html a)

weekday_columns weekdays =
    List.map  (\n -> div [class "col s1"] [text n]) weekdays
