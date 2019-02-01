module Fields.CustomField exposing (view, CustomField)

import Html exposing (Html, text, div, span, input)
import Html.Attributes exposing (class, type_, value, disabled)
import Html.Events exposing (onInput)

type alias CustomField a msg =
    { getter : Bool -> a -> Html msg
    --, setter : a -> Float -> msg
    }



view : CustomField a msg -> Bool ->  a -> Html msg
view field readOnly data =
    field.getter readOnly data
    -- input 
    --     [ type_ "number", class "input"
    --     , value ( String.fromFloat ( field.getter data ) )
    --     , onInput (\a -> String.toFloat a |> Maybe.withDefault 0 |> (field.setter data) )
    --     , disabled readOnly
    --     ]
    --     [ text ( String.fromFloat ( field.getter data ) )
    --     ]
        