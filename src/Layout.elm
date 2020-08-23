module Layout exposing
    ( Document
    , document
    , map
    , toBrowserDocument
    )

import Browser
import Html.Styled as Html exposing (Html)
import Style



--------------------------------------------------------------------------------
-- VIEW --
--------------------------------------------------------------------------------


type alias Document msg =
    { title : String
    , body : List (Html msg)
    }



--------------------------------------------------------------------------------
-- API --
--------------------------------------------------------------------------------


map : (a -> msg) -> Document a -> Document msg
map toMsg doc =
    { title = doc.title
    , body = List.map (Html.map toMsg) doc.body
    }


document : String -> List (Html msg) -> Document msg
document title body =
    { title = title
    , body = body
    }


toBrowserDocument : Document msg -> Browser.Document msg
toBrowserDocument doc =
    { title = doc.title
    , body = List.map Html.toUnstyled (Style.globals :: doc.body)
    }
