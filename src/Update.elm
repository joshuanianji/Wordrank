{-
   The update.elm continuously changes the model and executes commands. It is based on the messages which the view sends out (like from onClick functions, for example) and the Model, such as which directory we're in.
-}


module Update exposing (update)

import File exposing (File)
import File.Select as Select
import Model exposing (FileContent, Model)
import Msg exposing (Msg(..))
import StringParse exposing (toDuplicateTuples)
import Task


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ChangeDirectory dir ->
            ( { model | directory = dir }, Cmd.none )

        -- THIS SECTION IS ABOUT MESSAGES WHEN THE USER INPUTS A TEXT FILE
        -- this selected the file then automatically uploads the file via GotFile
        ReqFile ->
            -- Select.file makes sure only one file is selected.
            ( model, Select.file [ "*/*" ] GotFile )

        -- this uploads the file
        GotFile uploadedFile ->
            if (File.mime uploadedFile |> String.left 5) == "text/" |> Debug.log "FileLoaded" then
                -- I put `FileContent (Just uploadedFile) Nothing Nothing Nothing` to allow me to completely reset the fileCOntent thing
                ( { model
                    | fileContent =
                        FileContent
                            (Just uploadedFile)
                            Nothing
                            Nothing
                            False
                  }
                , Task.perform UploadFileContent (File.toString uploadedFile)
                )

            else
                ( model, Cmd.none )

        UploadFileContent fileContents ->
            let
                c =
                    model.fileContent
            in
            ( { model | fileContent = { c | fileText = Just fileContents } }, Cmd.none )

        -- this toggles if we're showing the files contents on the web page
        ToggleFileContents ->
            let
                c =
                    model.fileContent

                currentState =
                    model.fileContent.showingFileContents
            in
            ( { model | fileContent = { c | showingFileContents = not currentState } }, Cmd.none )

        -- when the user clicks the button on the input string page.
        -- here we'll just evaluate the buttons and stuff to make the data type in the Model
        EvalFileText ->
            let
                c =
                    model.fileContent

                fileString =
                    model.fileContent.fileText
            in
            ( { model | fileContent = { c | tupleList = toDuplicateTuples (Debug.log "Alrighty we're about to debug this" fileString) } }, Cmd.none )

        -- THIS SECTION IS ABOUT THE MESSAGES WHEN THE USER INPUTS THEIR OWN STRING
        UpdateInputText string ->
            let
                c =
                    model.inputContent
            in
            ( { model | inputContent = { c | text = Just string } }, Cmd.none )

        -- when the user clicks the button on the input string page.
        -- here we'll just evaluate the buttons and stuff to make the data type in the Model
        EvalInputText ->
            let
                c =
                    model.inputContent

                inputString =
                    model.inputContent.text
            in
            ( { model | inputContent = { c | tupleList = toDuplicateTuples inputString } }, Cmd.none )
