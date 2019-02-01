module Fields.GenericField exposing (view, BasicFieldInfo, GenericFieldType(..))

import Html exposing (Html, text, div, span, input)
import Html.Attributes exposing (class, type_, value, disabled)
import Html.Events exposing (onInput)

import Fields.StringField as StringField exposing(..)
import Fields.IntField as IntField exposing(..)
import Fields.FloatField as FloatField exposing(..)
import Fields.CustomField as CustomField exposing(..)

type GenericFieldType a msg
    = String (StringField a msg)
    | Int (IntField a msg)
    | Float (FloatField a msg)
    | Custom (CustomField a msg)

type alias BasicFieldInfo =
    { name : String
    , readOnly : Bool
    }

view : BasicFieldInfo -> GenericFieldType a msg -> a -> Html msg
view basic field data =
    div
        [ class "field string" ]
        [ span 
            [ class "title" ] 
            [ text basic.name 
            ]
        , ( case field of 
                String sf ->
                    StringField.view sf basic.readOnly data
                Int intf ->
                    IntField.view intf basic.readOnly data
                Float ff ->
                    FloatField.view ff basic.readOnly data
                Custom cu ->
                    CustomField.view cu basic.readOnly data
          )        
        ]