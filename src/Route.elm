module Route exposing
    ( Route(..)
    , fromUrl
    )

import Url exposing (Url)
import Url.Parser as P exposing (Parser)



---------------------------------------------------------------
-- TYPES --
---------------------------------------------------------------


type Route
    = Landing



---------------------------------------------------------------
-- API --
---------------------------------------------------------------


fromUrl : Url -> Maybe Route
fromUrl =
    P.parse parser



---------------------------------------------------------------
-- INTERNAL HELPERS --
---------------------------------------------------------------


parser : Parser (Route -> a) a
parser =
    [ P.map Landing P.top ]
        |> P.oneOf
