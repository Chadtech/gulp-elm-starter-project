module Model exposing
    ( Model
    , incrementTimesEnterWasPressed
    , setField
    , setSquareOfEnterPresses
    )

-- TYPES --


type alias Model =
    { field : String
    , timesEnterWasPressed : Int
    , squareOfEnterPresses : Int
    }



-- HELPERS --


setField : String -> Model -> Model
setField newField model =
    { model | field = newField }


setSquareOfEnterPresses : Int -> Model -> Model
setSquareOfEnterPresses newSquare model =
    { model | squareOfEnterPresses = newSquare }


incrementTimesEnterWasPressed : Model -> Model
incrementTimesEnterWasPressed model =
    { model | timesEnterWasPressed = model.timesEnterWasPressed + 1 }
