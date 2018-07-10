module Model exposing (Model, Status(..))


type alias Model =
    { name : String
    , counter : Int
    , status : Status
    }


type Status
    = Ready
    | Error String
    | Success
