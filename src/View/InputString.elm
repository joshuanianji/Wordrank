{-
   View when the user inputs their own string
-}


module View.InputString exposing (inputStringView)

import Colours exposing (appBackgroundGray)
import Element exposing (Attribute, Element, centerX, column, el, fill, height, maximum, minimum, padding, paddingXY, px, spacing, text, width)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input exposing (button, labelAbove, multiline)
import Model exposing (Directory(..), Model)
import Msg exposing (Msg(..))
import StringParse exposing (..)
import View.Navbar exposing (navbar)


inputStringView : Model -> Element Msg
inputStringView model =
    column
        [ width fill, padding 20, spacing 20 ]
        [ navbar model
        , Input.multiline
            [ padding 20
            , Background.color appBackgroundGray
            , height (fill |> minimum 200 |> maximum 300)
            ]
            { onChange = UpdateInputText
            , text =
                case model.inputContent.text of
                    Nothing ->
                        ""

                    Just string ->
                        string
            , placeholder = Nothing
            , label = labelAbove [] (text "input your string here")
            , spellcheck = False
            }
        , button
            [ padding 10, Border.width 1 ]
            { onPress = Just EvalInputText
            , label = el [ centerX ] (text "upload text")
            }
        , dataTable model
        ]


dataTable : Model -> Element Msg
dataTable model =
    case model.inputContent.tupleList of
        Nothing ->
            Element.none

        Just list ->
            let
                data =
                    toTypeAlias list
            in
            Element.indexedTable
                [ padding 10
                , Border.width 1
                ]
                { data = toTypeAlias list
                , columns =
                    [ { header = headerStyle ""
                      , width = px 50
                      , view =
                            \int datum ->
                                tableColumnStyle ((int + 1 |> String.fromInt) ++ ": ")
                      }
                    , { header = headerStyle "Word"
                      , width = fill
                      , view =
                            \int datum ->
                                tableColumnStyle datum.word
                      }
                    , { header = headerStyle "Occurence"
                      , width = fill
                      , view =
                            \int datum ->
                                tableColumnStyle (String.fromInt datum.occurence)
                      }
                    ]
                }


headerStyle : String -> Element Msg
headerStyle string =
    el [ Font.size 30, padding 10 ] (text string)


tableColumnStyle : String -> Element Msg
tableColumnStyle string =
    el
        [ tablePadding
        , tableBorders
        ]
        (text string)


tableBorders : Attribute Msg
tableBorders =
    Border.widthEach
        { bottom = 0
        , left = 0
        , right = 0
        , top = 1
        }


tablePadding : Attribute Msg
tablePadding =
    paddingXY 0 10
