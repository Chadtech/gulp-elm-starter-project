module Model exposing (Model)


type alias Model =
    { field : String
    , timesEnterWasPressed : Int
    , squareOfEnterPresses : Int
    }
