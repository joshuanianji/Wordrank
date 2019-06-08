{-
   This is how the Home page will be set up!
-}


module View.Home exposing (homePageView)

import Colours exposing (linkColor)
import Element exposing (Element, alignTop, centerX, centerY, column, el, fill, fillPortion, height, newTabLink, padding, paragraph, row, spacing, text, width)
import Element.Events exposing (onClick)
import Element.Font as Font
import Element.Input exposing (button)
import Model exposing (Directory(..), Model)
import Msg exposing (Msg(..))


homePageView : Model -> Element Msg
homePageView model =
    column
        [ width fill, height fill, padding 10 ]
        [ column
            [ height (fillPortion 5), centerX, centerY, spacing 20 ]
            [ -- big "wordsearch title"
              el
                [ Font.size 100, centerY ]
                (text "WordRank")

            -- to squish in the text and the anchor
            , el
                [ centerX, centerY, Font.size 20 ]
                (row
                    []
                    [ text "By Joshua Ji and "
                    , newTabLink
                        [ Font.color linkColor ]
                        { url = "https://elm-lang.org/"
                        , label = text "the Elm Language"
                        }
                    ]
                )
            ]

        -- these are the links to the pages
        , row
            [ padding 20, height (fillPortion 1), centerX, alignTop ]
            [ Element.Input.button
                [ padding 30 ]
                { onPress = Just (ChangeDirectory InputStringPage)
                , label = el [ centerX ] (text "Input a String")
                }
            , Element.Input.button
                [ padding 30 ]
                { onPress = Just (ChangeDirectory UploadTextFilePage)
                , label = el [ centerX ] (text "Upload your own text file")
                }
            ]
        ]
--}
