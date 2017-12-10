module Utils.Tuple exposing ((=>))


infixl 0 =>
(=>) : first -> second -> ( first, second )
(=>) first second =
    ( first, second )
