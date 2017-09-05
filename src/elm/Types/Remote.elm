module Types.Remote exposing (Remote(..))

import Http


type Remote a
    = Loading
    | Loaded (Result Http.Error a)
