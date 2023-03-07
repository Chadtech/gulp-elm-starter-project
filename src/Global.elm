module Global exposing
    ( Global
    , init
    )

import Browser.Navigation as Nav



---------------------------------------------------------------
-- TYPES --
---------------------------------------------------------------


type alias Global =
    { navKey : Nav.Key }



---------------------------------------------------------------
-- INIT --
---------------------------------------------------------------


init : Nav.Key -> Global
init navKey =
    { navKey = navKey }

