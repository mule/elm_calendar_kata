port module Calendar exposing (..)

import Html exposing ( text, div, Attribute)
import Html.Attributes exposing (class, classList)
import List exposing (concat)
import Html.App as Html
-- import Html.Events exposing (..)
import Debug
--import Task


main : Program Model
main =
    Html.programWithFlags
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }
--type alias Flags =
--    { weekdays : (List String)
--    , monthWeeks
--}
type alias Day =
    { weekDay : Int
    , date : Int
    , month : Int
    }

type alias Week =
    { weekOfYear : Int
    , dates : List Day
    }

type alias Model =
    { weekdays : List String
    , monthWeeks : List Week
    }

init : Model -> (Model, Cmd a )

init flags =
    Debug.log "init running"
    (flags, Cmd.none )

type Msg
    = GetMonth
    | Month Model

port monthRequest : Int -> Cmd msg

--send : String -> Cmd Msg
--send msg =
  --Task.perform weekdaysRequest weekdaysRequest (Task.succeed msg)

update : Msg -> Model -> (Model, Cmd Msg)

update action model =
    case action of
        GetMonth ->
            (model, monthRequest 1)
        Month response ->
            (response, Cmd.none)

port monthResponse : (Model -> msg) -> Sub msg

subscriptions : Model -> Sub Msg

subscriptions model =
    monthResponse Month

view : Model -> Html.Html Msg

view model =
    Debug.log (toString model)
    div [class "month"] (row [("weekdayRow", True)] (weekday_columns model.weekdays) :: week_rows model.monthWeeks)


row : List (String, Bool) -> List (Html.Html Msg) -> Html.Html Msg


row classes content  =
    div ( [ classList ([ ("row", True) ] ++ classes) ]) (div [class "col s2"] [] :: content ++ [div [class "col s3"] []])

weekday_columns : List String -> List (Html.Html a)

weekday_columns weekdays =
    List.map  (\n -> div [class "col s1 weekday"] [text n]) weekdays

week_columns : Week -> List (Html.Html a)

week_columns week =
     List.map (\day -> day_column day) week.dates

week_rows : List Week ->  List (Html.Html Msg)
week_rows weeks =
    List.map (\week -> row [("week", True)] (week_columns week)) weeks

day_column : Day -> Html.Html a
day_column day =
     div [class "col s1 day card-panel teal"] [text (toString day.date)]
