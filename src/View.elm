{-
   The view function decides which "subview" to use depending on the directory we're in, which we use the model for.
-}


module View exposing (view)

import Colours exposing (appBackgroundGray, fontColour)
import Element exposing (Element, FocusStyle)
import Element.Background as Background
import Element.Font as Font
import GithubLogo
import Html exposing (Html)
import Model exposing (Directory(..), Model)
import Msg exposing (Msg(..))
import View.Home exposing (homePageView)
import View.InputString exposing (inputStringView)
import View.Navbar exposing (navbar)
import View.UploadFile exposing (uploadTextFileView)



{-
   Element.layoutWith converts the Element Msg type to Html Msg.

   In the process, it makes all the fonts have a font family of "Lato" (taken from google's font library - i think) and have the font folour of fontColour, which is just white lol.

   It also makes the background a nice gray. You can see all these colours in detail in out Color.elm file.
-}


view : Model -> Html Msg
view model =
    Element.layoutWith
        { options = [ Element.focusStyle focusStyle ] }
        [ Font.family
            [ Font.external
                { name = "Lato"
                , url = "https://fonts.googleapis.com/css?family=Lato"
                }
            , Font.sansSerif
            ]
        , Font.color fontColour
        , Background.color appBackgroundGray
        , GithubLogo.view
            { href = "https://github.com/joshuanianji/HIIT-Timer"
            , bgColor = "rgb(215, 215, 215)"
            , bodyColor = "rgb(51, 51, 61)"
            }
            |> Element.el
                [ Element.alignRight
                , Element.alignTop
                ]
            |> Element.inFront
        ]
    <|
        case model.directory of
            HomePage ->
                homePageView model

            InputStringPage ->
                inputStringView model

            UploadTextFilePage ->
                uploadTextFileView model



-- this makes all the buttons not have that ugly blue border. uncomment this and change the view function so it'll not have the options = [ Element.focusStyle focusStyle ], and change layoutWith to layout. It'll be so much uglier lol.


focusStyle : FocusStyle
focusStyle =
    { borderColor = Nothing
    , backgroundColor = Nothing
    , shadow = Nothing
    }
