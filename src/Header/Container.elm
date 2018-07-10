module Header.Container
    exposing
        ( container
        )

import Header.View exposing (Props)
import Html.Provider as Provider exposing (Html)
import Model exposing (Model)
import Msg exposing (Msg)


mapStateToProps : Model -> Props
mapStateToProps model =
    { greeting =
        if String.isEmpty model.name then
            "Hello you!"
        else
            [ "Hello "
            , model.name
            , "!"
            ]
                |> String.concat
    }


container : Html Model Msg
container =
    Provider.connect
        Header.View.view
        mapStateToProps
