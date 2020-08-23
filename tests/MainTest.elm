module MainTest exposing (..)

-- These imports are unused, we but need them for Elm test to
-- run the tests in these modules, and fail when these modules
-- cant compile

import Expect
import Main
import Test exposing (Test)


test : Test
test =
    Test.test "Compiles" <| \_ -> Expect.equal 1 1
