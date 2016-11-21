module Flipper exposing (Flipper, Config, Action, initFlipper, update, view)

{-| Flipper is a component for presenting a flippable surface with a back and a front (think playing card). The card
can be flipped on mouseover or onclick of the area.

# Configuration
@docs Config
@docs initFlipper

# Elm Architecture
@docs Flipper
@docs Action
@docs update
@docs view
-}

import Html exposing (Html, div, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onMouseOut, onMouseOver)
import Html.Keyed exposing (..)


{-| -}
type Action
    = Clicked
    | MousedOver
    | MousedOut


{-| The configuration for the Flipper.
* flipOnClick : Should the flipper flip on mouse click (true) or mouse over (false)
* heightInPixels : The height of the flipper's container in pixels
* widthInPixels : The width of the flipper's container in pixesl
-}
type alias Config =
    { flipOnClick : Bool
    , heightInPixels : Int
    , widthInPixels : Int
    , front : Html Action
    , back : Html Action
    }


{-| -}
type alias Flipper =
    { flipped : Bool
    , config : Config
    }


{-| Initializes a Flipper ready to use in your model.
-}
initFlipper : Config -> Flipper
initFlipper config =
    { flipped = False
    , config = config
    }


{-| The update portion of the Elm Architecture.
-}
update : Action -> Flipper -> Flipper
update action flipper =
    case action of
        Clicked ->
            if flipper.config.flipOnClick then
                { flipper | flipped = not flipper.flipped }
            else
                flipper

        MousedOver ->
            if flipper.config.flipOnClick then
                flipper
            else
                { flipper | flipped = True }

        MousedOut ->
            if flipper.config.flipOnClick then
                flipper
            else
                { flipper | flipped = False }


frontStyle : Flipper -> List ( String, String )
frontStyle flipper =
    if flipper.flipped then
        face ++ flippedFront
    else
        face ++ front


backStyle : Flipper -> List ( String, String )
backStyle flipper =
    if flipper.flipped then
        face ++ flippedBack
    else
        face ++ back


{-| The view function of the Elm Architecture.
-}
view : Flipper -> Html Action
view flipper =
    div []
        [ div
            [ class "container"
            , style
                (cardContainer
                    ++ [ ( "height", ((toString flipper.config.heightInPixels) ++ "px") )
                       , ( "width", ((toString flipper.config.widthInPixels) ++ "px") )
                       ]
                )
            , onClick Clicked
            , onMouseOut MousedOut
            , onMouseOver MousedOver
            ]
            [ div [ style card ]
                -- Need to use keyed nodes so CSS transitions work
                [ node "div"
                    []
                    [ ( "front"
                      , div [ style (frontStyle flipper), class "flipperFace" ]
                            [ div [ style insideCard ] [ flipper.config.front ] ]
                      )
                    ]
                , node "div"
                    []
                    [ ( "back"
                      , div [ style (backStyle flipper), class "flipperFace" ]
                            [ div [ style insideCard ] [ flipper.config.back ] ]
                      )
                    ]
                ]
            ]
        ]



{- Style definitions (so no external CSS needs to be imported) -}


cardContainer : List ( String, String )
cardContainer =
    [ ( "position", "relative" )
    , ( "-webkit-perspective", "800px" )
    , ( "perspective", "800px" )
    , ( "margin", "2px" )
    ]


card : List ( String, String )
card =
    [ ( "position", "absolute" )
    , ( "width", "100%" )
    , ( "height", "100%" )
    , ( "-webkit-transform-style", "preserve-3d" )
    , ( "transform-style", "preserve-3d" )
    , ( "transition", "all 1.0s linear" )
    ]


face : List ( String, String )
face =
    [ ( "width", "100%" )
    , ( "height", "100%" )
    , ( "position", "absolute" )
    , ( "top", "0" )
    , ( "left", "0" )
    , ( "-webkit-backface-visibility", "hidden" )
    , ( "backface-visibility", "hidden" )
    , ( "-webkit-transform-style", "preserve-3d" )
    , ( "transform-style", "preserve-3d" )
    , ( "transition", "0.5s" )
    ]


front : List ( String, String )
front =
    [ ( "background", "white" )
    , ( "-webkit-transform", "rotateY(0deg)" )
    , ( "transform", "rotateY(0deg)" )
    ]


flippedFront : List ( String, String )
flippedFront =
    [ ( "background", "white" )
    , ( "-webkit-transform", "rotateY(-180deg)" )
    , ( "transform", "rotateY(-180deg)" )
    ]


back : List ( String, String )
back =
    [ ( "display", "block" )
    , ( "box-sizing", "border-box" )
    , ( "-webkit-transform", "rotateY(180deg)" )
    , ( "transform", "rotateY(180deg)" )
    ]


flippedBack : List ( String, String )
flippedBack =
    [ ( "display", "block" )
    , ( "box-sizing", "border-box" )
    , ( "-webkit-transform", "rotateY(0deg)" )
    , ( "transform", "rotate(0deg)" )
    ]


insideCard : List ( String, String )
insideCard =
    [ ( "overflow", "hidden" )
    , ( "width", "100%" )
    , ( "background", "white" )
    ]
