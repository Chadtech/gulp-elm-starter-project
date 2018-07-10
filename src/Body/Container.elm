module Body.Container
    exposing
        ( container
        )

import Body.View exposing (Props)
import Html.Provider as Provider exposing (Html)
import Model exposing (Model)
import Msg exposing (Msg)


mapStateToProps : Model -> Props
mapStateToProps model =
    { nameField = model.name
    , count = model.counter
    }


container : Html Model Msg
container =
    Provider.connect
        Body.View.view
        mapStateToProps
