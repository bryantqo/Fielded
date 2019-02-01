module Main exposing (..)

import Browser
import Html exposing (Html, text, div, h1, img, span)
import Html.Attributes exposing (src, class)

import Fields.GenericField as GenericField exposing(..)
import Fields.GenericField exposing(GenericFieldType)

import Fields.StringField as StringField exposing(..)
import Fields.IntField as IntField exposing(..)
import Fields.FloatField as FloatField exposing(..)
import Fields.CustomField as CustomField exposing(..)

---- MODEL ----


type alias Model =
    { data : Data
    }


type alias Data =
    { name : String
    , count : Int
    , area : Float
    }

init : ( Model, Cmd Msg )
init =
    ( { data = demoData }, Cmd.none )



---- UPDATE ----


type Msg
    = NoOp
    | Update Data


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Update data ->
            (   { model 
                | data = data 
                }
            , Cmd.none
            )
        _ ->
            ( model, Cmd.none )



---- VIEW ----
demoStringField1 : StringField.StringField Data Msg
demoStringField1 =
    { getter = ( .name )
    , setter = (\a -> \b -> Update { a | name = b })
    }

demoIntField1 : IntField.IntField Data Msg
demoIntField1 =
    { getter = ( .count )
    , setter = (\a -> \b -> Update { a | count = b })
    }


demoFloatField1 : FloatField.FloatField Data Msg
demoFloatField1 =
    { getter = ( .area )
    , setter = (\a -> \b -> Update { a | area = b })
    }

demoCustomField1 : CustomField.CustomField Data Msg
demoCustomField1 =
    { getter = 
        (\readOnly -> \a ->
            ( div 
                []
                [ span 
                    [] 
                    [ text a.name 
                    ]
                , span
                    []
                    [ text ( String.fromInt a.count )
                    ] 
                ]
            )
        )
    }

demoData : Data
demoData =
    { name = "Test Data"
    , count = 7
    , area = 21.12
    }



view : Model -> Html Msg
view model =
    div []
        [ fieldRow model False
        , fieldRow model True
        ]


fields : Bool -> List (BasicFieldInfo, GenericFieldType Data Msg )
fields readOnly = 
    [ ( {name = "Name", readOnly = readOnly }, (GenericField.String demoStringField1) )
    , ( {name = "Count", readOnly = readOnly }, (GenericField.Int demoIntField1) )
    , ( {name = "Area", readOnly = readOnly }, (GenericField.Float demoFloatField1) )
    , ( {name = "Custom", readOnly = readOnly }, (GenericField.Custom demoCustomField1 ) )
    ]

fieldsView : Model -> Bool -> Html Msg
fieldsView model readOnly =
    div 
        [ class "row" ]
        ( List.map (fieldView model.data) ( fields readOnly )
        )

fieldView : Data -> (BasicFieldInfo, GenericFieldType Data Msg) -> Html Msg
fieldView data (basic, field) =
    div
        [ class "cell"
        ]
        [ GenericField.view basic field data
        ]

fieldRow : Model -> Bool -> Html Msg
fieldRow model readOnly =
    fieldsView model readOnly
    -- div 
    --     [ class "row" ]
    --     [ div
    --         [ class "cell"
    --         ]
    --         [ GenericField.view {name = "Name", readOnly = readOnly } (GenericField.String demoStringField1) model.data
    --         ]
    --     , div
    --         [ class "cell"
    --         ]
    --         [ GenericField.view {name = "Count", readOnly = readOnly } (GenericField.Int demoIntField1) model.data
    --         ]
    --     , div
    --         [ class "cell"
    --         ]
    --         [ GenericField.view {name = "Area", readOnly = readOnly } (GenericField.Float demoFloatField1) model.data
    --         ]
    --     ]


---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }
