import Html exposing (program, div, button, text)
import Html.Events exposing (onClick)
import Random exposing (Generator, Seed)
import Dict

main =
    program
        { init =
            ( { seed = Nothing, position = 0, desc = " .. " }
            , Random.generate Update randomNumberGenerator
            )
        , view = view
        , update = update
        , subscriptions = \model -> Sub.none
        }


view model =
    div []
        [ button
            [ onClick PlayAgain ]
            [ text " -- Play --" ]
        , text (toString model.position)
        , text (model.desc)
        ]


type alias Model =
    { seed : Maybe Seed
    , position : Int
    , desc : String
    }


type Msg
    = Update Seed
    | PlayAgain


randomNumberGenerator : Generator Seed
randomNumberGenerator =
    Random.int Random.minInt Random.maxInt
        |> Random.map (Random.initialSeed)


update msg model =
    case msg of
        Update seed ->
            -- Preserve newly initialized Seed state.
            ( { model | seed = Just seed }, Cmd.none )

        PlayAgain ->
            let
                -- In case if seed was present, new model will contain the new value and a new state for the seed.
                board = Dict.fromList [(99,54), (70,55), (52,42), (25,2), (95,72), (6, 26), (11, 40), (60, 41), (46, 90)]
     
                newModel =
                    model.seed
                        |> Maybe.map (Random.step (Random.int 1 6))
                        |> Maybe.map
                            (\( number, seed ) ->
                                { model | seed = Just seed, position = number + model.position, desc = model.desc  ++ " Dice Roll, Number: " ++ toString number }
                            )
                        |> Maybe.withDefault model  

                positionAfterSnakeLadderCheck =
                    if newModel.position >= 100 then
                        100
                    else                        
                        case Dict.get newModel.position board of
                          Just value -> value                    
                          Nothing -> newModel.position

                updatedDesc = 
                    newModel.desc ++
                    if positionAfterSnakeLadderCheck /= newModel.position then
                        " Snake/Ladder Found at number: " ++ toString newModel.position ++ 
                        " Updating Position to: " ++ toString positionAfterSnakeLadderCheck 
                    else
                        " Continue .. "    

                checkIfWon =
                    if positionAfterSnakeLadderCheck >= 100 then
                        " WON !!"
                    else
                        updatedDesc

            in
                ( { newModel | position = positionAfterSnakeLadderCheck, desc = checkIfWon }
                , Cmd.none
                )


