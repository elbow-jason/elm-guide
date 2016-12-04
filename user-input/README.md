# user-input.elm

  + [Elm Docs](https://guide.elm-lang.org/architecture/user_input/)

  + [Declaration Wiki](https://en.wikipedia.org/wiki/Declaration_(computer_programming)

  + [Type System Wiki](https://en.wikipedia.org/wiki/Type_system)

# The Code
```elm
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


```

# The `main` Function

```elm
-- MAIN
main =
  Html.beginnerProgram { model = model, view = view, update = update }
```

The `main` function is the entrypoint for an application just like C++,
Golang, etc.

Google `if __name__ == "__main__":` for a Python description. (kind of? close enough.)

`main` is where the program starts when it is run.

There is a lot going on inside `main`'s code block above. The ins and outs of what is going on is noted at the end of this page.

# The `Model`

```elm
-- MODEL
type alias Model =
  { content : String
  }

model : Model
model =
  { content = "" }
```

The model code consists of three parts the __Type Definition__, the __Variable Declaration__, and the __Variable Initialization__.

----------------------

###### Type Definition

```elm
type alias Model =
  { content : String
  }
```

The `Model` type alias is the definition of the shape of the data that this module is concerned with. The shape of the data will hold the state that this module's `Update` functions will manipulate. In this case the `Model` is simple. The `Model` has one field named `content` that is of type `String`. Given the block of code above, our model can keep track of the string content of something. In this example the `content` of our `model` (which is of type `Model`) keeps track of the user's text input.

---------------------------

###### Variable Declaration

```elm
model : Model
```

This is variable delcaration for an "instance" of our `Model`. In JavaScript, the equivalent is `var model;`. However, in the case of Elm the delcaration is a static typing for the variable. "Static type" means that a variable and it's type cannot be changed at runtime.

Basically we are telling the compiler that we are going to use a variable `model` that is of type `Model`. This allows to compiler to strictly enforce:

  1. what functions can accept this variable `model` as an argument and

  1. when can be done to the model variable (for example one may not update a field called `age` on the `model` variable without first adding an `age` field to the `Model` definition above)


------------------------------

###### Variable Initialization/Definition

```elm
model =
  { content = "" }
```

We are are initializing the variable `model` with the state of `content` as an empty string. The only valid values to initialize the `content` field must be a String. In this example any valid initial value besides an empty string will initially appear as reveresed text below the `<input>` tag in the html.


# The `Update`

```elm
-- UPDATE
type Msg
  = Change String

update : Msg -> Model -> Model
update msg model =
  case msg of
    Change newContent ->
      { model | content = newContent }
```

The `Update` code defines the when and how the `model` is updated given an the
occurrence of an event.


###### Payload Type Definition

```elm
type Msg
  = Change String
```

The code above defines a type `Msg` that is a `Change` where the `Change` holds (or wraps) a `String`

###### Function Declaration and Signature

```elm
update : Msg -> Model -> Model
```

The code above declares a function called `update` that receives a `Msg` and returns a function that takes a `Model` and returns a function that will return a `Model`.
(this description might need / probably needs work)

###### Function Definition

```elm
update msg model =
  case msg of
    Change newContent ->
      { model | content = newContent }
```

In the code above the `update` function's definition. The function's arguments' behaviors are defined in accordance with each of their own type definitions in the previous sections. The `update` function's first argument is `msg` which is of type `Msg` (enforced strictly by the Elm compiler), it's second argument is `model` which is of type `Model`. There are at least 4 significant and potentially unfamiliar things happening in this short block of code:

  1. Unlike most programming language with which I am familiar (meaning this is subjective) the arguments of a function's definition are not comma separated, but instead are space separated. Additionally, the function's definition of args is not delimited by parenthesis. See `update msg model =` above.

  1. The types of the two argument's `msg` and `model` match the types first two types from the `update` function's definition `Msg -> Model -> Model`. In the `update` function's definition the last `Model` is the return type of this function `{ model | content = newContent }`.

  1. The `msg` which we're considering the payload (the thing that is being moved to a target) of this `Update` function is a type of `Change`. When this `Change` is `case`d upon the `case` statement exposes the `String` that it is wrapping.

  1. The last thing on my list of significant things is called (subjectively) record literal update syntax. In non-functional programming languages one may update the values of an object with assignment into an object's fields using dot syntax. For example one may do this in JavaScript:

  ```javascript
  var newContent = "Jessica Jones";
  var model = {content: "Killgrave"};
  model.content = newContent;
  ```

  This is mutation and in functional programming languages this is not possible. Sorry, JS. You're not quite functional. In functional programming, we're forced to use a different technique that won't mutate the source object. This is record literal update syntax:

  ```elm
    { model | content = newContent }
  ```

  It can be read aloud as "Make a copy of the `model` object's type and fields except the `content` field. Set the `content` field of the copy equal to `newContent`."

If you are familiar with the JavaScript library Redux you may notice direct similarities between the signature and structure of a Reducer and an Update function in Elm. They are in fact the same in use and form. Redux was based on Elm architecture.


# The `View`

The view is the last part.
