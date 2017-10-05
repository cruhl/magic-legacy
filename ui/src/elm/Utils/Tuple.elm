module Utils.Tuple exposing ((=>))


infixl 0 =>
(=>) : a -> b -> ( a, b )
(=>) =
    (,)
