module Html.Custom
    exposing
        ( input
        , lightGray
        , p
        , red
        , white0
        , white1
        )

import Css exposing (..)
import Html.Styled as Html exposing (Attribute, Html)
import Html.Styled.Attributes exposing (css)


input : List (Attribute msg) -> List (Html msg) -> Html msg
input attrs =
    Html.input (inputCss :: attrs)


inputCss : Attribute msg
inputCss =
    [ fontFamilies [ "Arial" ]
    , color black
    , fontSize (em 2)
    , backgroundColor white1
    , border3 (px 2) solid lightGray
    , outline none
    , width (px 500)
    ]
        |> css


p : List (Attribute msg) -> List (Html msg) -> Html msg
p attrs =
    Html.p (pCss :: attrs)


pCss : Attribute msg
pCss =
    [ fontFamilies [ "Arial" ]
    , color black
    ]
        |> css



-- COLORS --


black : Color
black =
    hex "#030907"


white0 : Color
white0 =
    hex "#fcf7f9"


white1 : Color
white1 =
    hex "#f9fcfb"


lightGray : Color
lightGray =
    hex "#d0b5a9"


red : Color
red =
    hex "#f21d23"
