module Fields.IntField exposing (view, IntField)

import Html exposing (Html, text, div, span, input)
import Html.Attributes exposing (class, type_, value, disabled)
import Html.Events exposing (onInput)

type alias IntField a msg =
    { getter : a -> Int
    , setter : a -> Int -> msg
    }



view : IntField a msg -> Bool -> a -> Html msg
view field readOnly data =
    input 
        [ type_ "number", class "input"
        , value ( String.fromInt ( field.getter data ) )
        , onInput (\a -> String.toInt a |> Maybe.withDefault 0 |> (field.setter data) )
        , disabled readOnly
        ]
        [ text ( String.fromInt ( field.getter data ) )
        ]
    