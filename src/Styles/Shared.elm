module Styles.Shared exposing (..)

import Css exposing (Color, hex)
import Html.CssHelpers exposing (withNamespace)


type Classes
    = Field
    | Point
    | Big


appNameSpace : String
appNameSpace =
    "app-name"



-- COLORS --


almostBlack : Color
almostBlack =
    hex "#030907"


almostWhite : Color
almostWhite =
    hex "#fcf7f9"


offWhite : Color
offWhite =
    hex "#f9fcfb"


lightGray : Color
lightGray =
    hex "#d0b5a9"


red : Color
red =
    hex "#f21d23"
