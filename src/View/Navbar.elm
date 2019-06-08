module View.Navbar exposing (navbar)

import Element exposing (Attribute, Element, centerX, el, fill, padding, row, text, width)
import Element.Events as Events
import Element.Font as Font
import Element.Input exposing (button)
import Model exposing (Directory(..), Model)
import Msg exposing (Msg(..))



{-

   made the navbarElementAttributes so I can underline which directory I'm under

   Also used `alignLeft ::` just cause its easier that way. If i put it in the navbarElementAttributes i would have to make cases examining the `dir` and that won't be nice.

-}


navbar : Model -> Element Msg
navbar model =
    row [ padding 10, width fill ]
        [ button
            (navbarElementAttributes model HomePage)
            { onPress = Just (ChangeDirectory HomePage)
            , label = el [ centerX ] (text "Home")
            }
        , button
            (navbarElementAttributes model InputStringPage)
            { onPress = Just (ChangeDirectory InputStringPage)
            , label = el [ centerX ] (text "Input a String")
            }
        , button
            (navbarElementAttributes model UploadTextFilePage)
            { onPress = Just (ChangeDirectory UploadTextFilePage)
            , label = el [ centerX ] (text "upload text file")
            }
        ]



-- checks to see in the model if we're in that specific directory. if we are we underline the text.


navbarElementAttributes : Model -> Directory -> List (Attribute Msg)
navbarElementAttributes model dir =
    let
        basicNavBarAttributes =
            [ padding 10, width fill ]
    in
    if model.directory == dir then
        Font.underline :: basicNavBarAttributes

    else
        basicNavBarAttributes
