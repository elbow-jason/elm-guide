import Html
import Html.Attributes as Attributes
import Html.Events as Events
import String


-- MAIN
main =
  Html.beginnerProgram { model = model, view = view, update = update }

-- MODEL
type alias Model =
  { content : String
  }

model : Model
model =
  { content = "" }

-- UPDATE
type Msg
  = Change String

update : Msg -> Model -> Model
update msg model =
  case msg of
    Change newContent ->
      { model | content = newContent }


-- VIEW

view : Model -> Html.Html Msg
view model =
  Html.div []
    [ Html.input [ Attributes.placeholder "Text to reverse", Events.onInput Change ] []
    , Html.div [] [ Html.text (String.reverse model.content) ]
    ]
