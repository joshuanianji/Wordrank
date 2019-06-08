{-

   COMMENTS ABOUT THE MSG TYPE:

   ChangeDirectory literally changes directory lol. Check the update function if you're not sure.

   ReqFile and GotFile uploads the text file.
   LoadFileContents and ShowFileContents puts the text file contents into the model.

-}


module Msg exposing (Msg(..))

import File exposing (File)
import Model exposing (Directory)


type Msg
    = ChangeDirectory Directory
    | ReqFile
    | GotFile File
    | UploadFileContent String
    | ToggleFileContents
    | EvalFileText
    | UpdateInputText String
    | EvalInputText
