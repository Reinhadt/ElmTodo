-- Read all about this program in the official Elm guide:
-- https://guide.elm-lang.org/architecture/user_input/forms.html


module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onSubmit, onInput)
import Html.App as App


main : Program Never
main =
    App.beginnerProgram
        { model = initModel
        , view = view
        , update = update
        }



-- MODEL


type alias Model =
    { tarea : List Tareas
    , nombre : String
    }


type alias Tareas =
    { nombre : String
    }


initModel : Model
initModel =
    { tarea = []
    , nombre = ""
    }



-- UPDATE


type Msg
    = UpdateModelo String
    | UpdateTarea


update : Msg -> Model -> Model
update msg model =
    case msg of
        UpdateModelo todo ->
            { model | nombre = todo }

        UpdateTarea ->
            save model


save : Model -> Model
save model =
    let
        lista =
            Tareas model.nombre

        newTareas =
            lista :: model.tarea
    in
        { model
            | tarea = newTareas
            , nombre = ""
        }



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ todoForm model
        , todoList model
        ]


todoForm : Model -> Html Msg
todoForm model =
    Html.form [ onSubmit UpdateTarea ]
        [ input [ type' "text", placeholder "Name", onInput UpdateModelo, value model.nombre ] []
        , button [ type' "submit" ] [ text "PÍCALE" ]
        , p [] [ text (toString model) ]
        ]


todoList : Model -> Html Msg
todoList model =
    ul []
        (List.map todos model.tarea)


todos : Tareas -> Html Msg
todos t =
    li []
        [ p [] [ text (toString t.nombre) ]
        ]
