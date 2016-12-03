import Html
import Html.Attributes as Attributes
import Html.Events as Events
import String

{-
  -- MAIN
  `main` function is the entrypoint for an application just like C++,
  Golang, etc.

  Google `if __name__ == "__main__":` for a Python description.
  (kind of? close enough.)

  `main` is where the program starts when it is run.
-}
main =
  Html.beginnerProgram { model = model, view = view, update = update }

{-
  -- MODEL
  The `Model` type alias is the definition of the shape of the data that this
  module is concerned with. The shape of the data will hold the state that this
  module's Update functions will manipulate.
  In this case the `Model` is simple. The `Model` has one field named `content`
  that is of type `String`.
-}

{-
  This is the type definition of our `Model`. Here we define the data our model
  can keep track of (preposition ending sentence?).
  Given the following definition, our model can keep track of
  the string content of something. In this example the `content` of our `model`
  (which is of type `Model`) keeps track of the user's text input.
-}
type alias Model =
  { content : String
  }

{-
  With regards to the line `model : Model`
  This is variable delcaration for an "instance" of our `Model`.
  In javascript the equivalent is `var model;`.
  However, in the case of Elm the delcaration is a static typing for the
  variable. "Static type" means that a variable and it's type cannot be
  changed at runtime.
  See https://en.wikipedia.org/wiki/Declaration_(computer_programming)
  See https://en.wikipedia.org/wiki/Type_system
  Basically we are telling the compiler that we are going to use a
  variable `model` that is of type `Model`. This allows to compiler to strictly
  enforce:
    1) what functions can accept this variable `model` as an argument and
    2) when can be done to the model variable (for example one may not update a
       field called `age` on the `model` variable without first adding an `age`
       field to the `Model` definition above)


  With regards to the 2 lines
    ```
      model =
        { content = "" }
    ```
  We are are initializing the variable `model` with the state of `content` as
  an empty string. The only valid values to initialize the `content` field must
  be a String. In this example any valid initial value besides an empty string
  will initially appear as reveresed text below the <input> tag in the html.
-}
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
