module View exposing (view)

import Body.Container as Body
import Footer.Container as Footer
import Header.Container as Header
import Html.Provider exposing (Html, div)
import Model exposing (Model)
import Msg exposing (Msg(..))


-- VIEW --


view : Html Model Msg
view =
    div
        []
        [ Header.container
        , Body.container
        , Footer.container
        ]
