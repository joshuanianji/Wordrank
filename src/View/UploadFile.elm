{-
   View when the user uploads a file
-}


module View.UploadFile exposing (uploadTextFileView)

import Element exposing (Attribute, Element, centerX, column, el, fill, height, maximum, padding, paddingXY, px, scrollbarX, scrollbarY, spacing, text, width)
import Element.Border as Border
import Element.Events exposing (onClick)
import Element.Font as Font
import Element.Input exposing (button)
import File exposing (File)
import Model exposing (Directory(..), Model)
import Msg exposing (Msg(..))
import StringParse exposing (..)
import View.Navbar exposing (navbar)



-- this is the view where the use uploads their own text file


uploadTextFileView : Model -> Element Msg
uploadTextFileView model =
    Element.column
        [ width fill, padding 20 ]
        [ navbar model
        , ifFileSelected model
        , dataTable model
        ]



-- this view shows only if a file is selected


ifFileSelected : Model -> Element Msg
ifFileSelected model =
    case model.fileContent.file of
        Just file ->
            column [ width fill, centerX, paddingXY 0 30, spacing 10 ]
                [ -- button to select another file
                  button buttonStyling
                    { onPress = Just (Debug.log "oh yeah they just pressed" ReqFile)
                    , label = text "Select a different .txt file"
                    }

                -- text to display file name
                , el [ padding 10, centerX ]
                    (text
                        ("You've selected: "
                            ++ File.name file
                        )
                    )

                -- this handles all the preview content stuff (button and text)
                , previewContents model

                -- button with the analyze text
                , button buttonStyling
                    { onPress = Just EvalFileText
                    , label = text "Evaluate Text"
                    }
                ]

        Nothing ->
            Element.column [ width fill, centerX, paddingXY 0 30 ]
                [ button buttonStyling
                    { onPress = Just ReqFile
                    , label = text "Select a .txt file"
                    }
                , el [ centerX, padding 10 ]
                    (text "No .txt file selected")
                ]



-- the part where there is the preview content button and the file contents


previewContents : Model -> Element Msg
previewContents model =
    column [ centerX, spacing 10 ]
        -- button to preview file contents
        [ button buttonStyling
            { onPress = Just ToggleFileContents
            , label =
                if model.fileContent.showingFileContents then
                    text "Hide Preview"

                else
                    text "Preview file contents"
            }

        -- file contents
        , el
            (fileContentAttributes model)
            (text <|
                case model.fileContent.fileText of
                    Just fileContent ->
                        if model.fileContent.showingFileContents then
                            fileContent

                        else
                            ""

                    Nothing ->
                        -- this shouldn't happen!!!!
                        ""
            )
        ]



-- this changes the file content thing, so if there's content we'll add a border but nothing if there isn't


fileContentAttributes : Model -> List (Attribute Msg)
fileContentAttributes model =
    let
        attributes =
            [ padding 10
            , height
                (fill
                    |> maximum 300
                )
            , width (px 700)
            , scrollbarY
            , scrollbarX
            ]
    in
    case model.fileContent.fileText of
        Just fileContent ->
            if model.fileContent.showingFileContents then
                Border.width 1 :: attributes

            else
                attributes

        Nothing ->
            -- this shouldn't happen!!!!
            attributes



-- styling for buttons


buttonStyling : List (Attribute Msg)
buttonStyling =
    [ Border.width 1, Border.rounded 2, padding 10, centerX ]



-- table to display the words and stuff


dataTable : Model -> Element Msg
dataTable model =
    case model.fileContent.tupleList of
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
