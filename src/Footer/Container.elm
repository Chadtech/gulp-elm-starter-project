module Footer.Container
    exposing
        ( container
        )

import Footer.View exposing (Props)
import Html.Provider as Provider exposing (Html)
import Model exposing (Model, Status(..))
import Msg exposing (Msg)


mapStateToProps : Model -> Props
mapStateToProps model =
    { disabled = String.isEmpty model.name && model.counter > 0
    , message =
        case model.status of
            Ready ->
                Nothing

            Error str ->
                Just str

            Success ->
                Just "Youve submitted your count!"
    }


container : Html Model Msg
container =
    Provider.connect
        Footer.View.view
        mapStateToProps
