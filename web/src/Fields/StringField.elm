module Fields.StringField exposing (view, StringField)

import Html exposing (Html, text, div, span, input)
import Html.Attributes exposing (class, type_, value, disabled)
import Html.Events exposing (onInput)

type alias StringField a msg =
    { getter : a -> String
    , setter : a -> String -> msg
    }


view : StringField a msg -> Bool -> a -> Html msg
view field readOnly data =
    input 
        [ type_ "text", class "input"
        , value ( field.getter data )  
        , onInput (field.setter data)
        , disabled readOnly
        ]
        [ text ( field.getter data ) 
        ]
        