module Styles exposing (css)

import Css exposing (..)
import Css.Elements exposing (body)
import Css.Namespace exposing (namespace)
import Styles.Shared exposing (..)


css =
    (stylesheet << namespace appNameSpace)
        [ body
            [ backgroundColor almostWhite ]
        , class Field
            [ fontFamilies [ "Arial" ]
            , color almostBlack
            , fontSize (em 2)
            , backgroundColor offWhite
            , border3 (px 2) solid lightGray
            , outline none
            , width (px 500)
            ]
        , class Point
            [ fontFamilies [ "Arial" ]
            , color almostBlack
            , withClass Big
                [ fontSize (em 4) ]
            ]
        ]
