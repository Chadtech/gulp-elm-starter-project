module Main exposing (..)

import Html exposing (Html)
import Html.Provider as Provider
import Model exposing (Model, Status(..))
import Msg exposing (Msg(..))
import View exposing (view)


-- MAIN --


main : Program Never Model Msg
main =
    { model = init
    , view = Provider.render view
    , update = update
    }
        |> Html.beginnerProgram


init : Model
init =
    { name = ""
    , counter = 0
    , status = Ready
    }



-- UPDATE --


update : Msg -> Model -> Model
update msg model =
    case msg of
        NameFieldUpdated str ->
            { model | name = str }

        Increment ->
            { model | counter = model.counter + 1 }

        Decrement ->
            { model | counter = model.counter - 1 }

        Submit ->
            { model
                | status =
                    case ( model.name, model.counter ) of
                        ( "", _ ) ->
                            Error "You must have a name to submit"

                        ( _, 0 ) ->
                            Error "You must have a count greater than 0 to submit"

                        _ ->
                            Success
            }
