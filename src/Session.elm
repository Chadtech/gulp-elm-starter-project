module Session exposing
    ( Session
    , init
    )

import Browser.Navigation as Nav



---------------------------------------------------------------
-- TYPES --
---------------------------------------------------------------


type alias Session =
    { navKey : Nav.Key }



---------------------------------------------------------------
-- INIT --
---------------------------------------------------------------


init : Nav.Key -> Session
init navKey =
    { navKey = navKey }
