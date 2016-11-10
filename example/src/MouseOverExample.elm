module Main exposing (..)

import Html.App as App
import Html exposing (div, h3, text, img, Html)
import Html.Attributes exposing (style, src)
import Flipper exposing (Config, Action, initFlipper, update, view)


main : Program Never
main =
    App.beginnerProgram
        { model = initFlipper (myConfig)
        , view = view
        , update = update
        }


myConfig : Config
myConfig =
    { flipOnClick = False
    , heightInPixels = 200
    , widthInPixels = 200
    , front = front
    , back = back
    }


front : Html Action
front =
    div [ style [ ( "text-align", "center" ) ] ]
        [ h3 [] [ text "FRONT" ]
        , div [] [ text "Mouse Over to flip" ]
        ]


back : Html Action
back =
    div [ style [ ( "text-align", "center" ) ] ]
        [ h3 [ style [ ( "background", "yellow" ) ] ] [ text "BACK" ]
        , div [] [ text "With more content, too." ]
        , img [ src "img/open-book.svg" ] []
        ]
