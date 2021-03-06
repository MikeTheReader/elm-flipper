module Main exposing (..)

import Html exposing (div, h3, text, img, Html, beginnerProgram)
import Html.Attributes exposing (style, src)
import Flipper exposing (Flipper, Config, Action, initFlipper, update, view)


main : Program Never Flipper Action
main =
    beginnerProgram
        { model = initFlipper (myConfig)
        , view = view
        , update = update
        }


myConfig : Config
myConfig =
    { flipOnClick = True
    , heightInPixels = 200
    , widthInPixels = 200
    , front = front
    , back = back
    }


front : Html Action
front =
    div [ style [ ( "text-align", "center" ) ] ]
        [ h3 [] [ text "FRONT" ]
        , div [] [ text "Click to flip" ]
        ]


back : Html Action
back =
    div [ style [ ( "text-align", "center" ) ] ]
        [ h3 [ style [ ( "background", "yellow" ) ] ] [ text "BACK" ]
        , div [] [ text "With more content, too." ]
        , img [ src "img/open-book.svg" ] []
        ]
