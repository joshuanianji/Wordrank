{-
   This module just defines a bunch of colours.
-}


module Colours exposing (appBackgroundGray, fontColour, linkColor)

import Element exposing (Color, rgb, rgb255)



-- main background color


appBackgroundGray : Color
appBackgroundGray =
    rgb255 51 51 61



-- font colour (hint it's white!)


fontColour : Color
fontColour =
    rgb255 215 215 215


linkColor : Color
linkColor =
    rgb255 46 85 118
