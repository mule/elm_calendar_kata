port module Calendar exposing (..)

import Html exposing ( a, text, div, h4, i, span, Attribute)
import Html.Attributes exposing (class, classList)
import List exposing (concat, map2)
import Html.App as Html
import String exposing (join)
import Array exposing (Array)
import Html.Events exposing (onClick)
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
    , months : List String
    , selectedMonth : Int
    , selectedYear : Int
    }

type alias MonthRequestResponse =
    { selectedMonth : Int
    , selectedYear : Int
    , monthWeeks : List Week}


init : Model -> (Model, Cmd a )

init flags =
    Debug.log "init running"
    (flags, Cmd.none )

type Msg
    = GetMonth (Int,Int)
    | Month MonthRequestResponse

port monthRequest : (Int,Int) -> Cmd msg

--send : String -> Cmd Msg
--send msg =
  --Task.perform weekdaysRequest weekdaysRequest (Task.succeed msg)

update : Msg -> Model -> (Model, Cmd Msg)

update  action model =
    case Debug.log "action" action of
        GetMonth (month, year) ->
            (model, monthRequest (month, year))
        Month response ->
            ( { model | monthWeeks = response.monthWeeks,
                        selectedMonth = response.selectedMonth,
                        selectedYear = response.selectedYear
                } , Cmd.none)

port monthResponse : (MonthRequestResponse -> msg) -> Sub msg

subscriptions : Model -> Sub Msg

subscriptions model =
    monthResponse  Month

view : Model -> Html.Html Msg

view model =
    --Debug.log (toString model)
    let
        monthName =
            Maybe.withDefault "Unknown" <| Array.get model.selectedMonth (Array.fromList model.months)
    in
            div [class "month"] ((month_row model.selectedMonth monthName model.selectedYear) :: row [("weekdayRow", True)] (weekday_columns model.weekdays) :: week_rows model.monthWeeks)

row : List (String, Bool) -> List (Html.Html Msg) -> Html.Html Msg

row classes content  =
    div ( [ classList ([ ("row", True) ] ++ classes) ]) (div [class "col s2"] [] :: content ++ [div [class "col s3"] []])

weekday_columns : List String -> List (Html.Html a)

weekday_columns weekdays =

    List.map  (\weekday -> div
                        [
                            classList [
                            ("col", True),
                            ("s1", True),
                            ("weekday", True),
                            ("offset-s2", (fst weekday) == 1)
                            ]
                        ]
                        [text <| snd weekday]) <| map2 (,) [1..7] weekdays

week_columns : Week -> List (Html.Html a)

week_columns week =
     List.map (\day -> day_column day) week.dates

week_rows : List Week ->  List (Html.Html Msg)
week_rows weeks =
    List.map (\week -> week_row week) weeks

week_row : Week -> Html.Html a
week_row week =
    div [ class "row week"] (div [class "col s1 offset-s1"] [text (toString week.weekOfYear)] :: week_columns week)

day_column : Day -> Html.Html a
day_column day =
     div [class "col s1 day card-panel teal"] [text (toString day.date)]

nextMonth : Int -> Int -> (Int,Int)
nextMonth currentMonth currentYear  =
    if currentMonth == 11 then
        (0,currentYear + 1)
    else
        (currentMonth + 1, currentYear)

prevMonth : Int -> Int -> (Int,Int)

prevMonth currentMonth currentYear =
    if currentMonth == 0 then
        (11, currentYear - 1)
    else
        (currentMonth - 1, currentYear)


month_row : Int -> String -> Int -> Html.Html Msg

month_row month monthName year =
        row [] [monthDesc_column month monthName year]

monthDesc_column : Int -> String -> Int -> Html.Html Msg
monthDesc_column month monthName year =
    let
        prevMonthBtn =
            a [class "btn-floating  waves-effect waves-light", onClick <| GetMonth <| prevMonth month year ] [ i [ class "material-icons"] [text "skip_previous"]]
        nextMonthBtn =
            a [class "btn-floating  waves-effect waves-light", onClick <| GetMonth <| nextMonth month year ] [ i [class "material-icons"] [text "skip_next"]]
        desc =
            span [class "month-description"] [text <| join " " [monthName, (toString year)]]
    in
        div [ class "col s7 offset-s2"] [h4 [class "center-align"]  [prevMonthBtn, desc, nextMonthBtn]]
