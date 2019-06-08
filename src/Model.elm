{-
   Mainly describes the data structures I'm going to use and our Model.

   the Model holds the data our app is going to use, and I need to define it by a type alias, which is basically a Javascript Object.
-}


module Model exposing (Directory(..), FileContent, InputContent, Model)

import File exposing (File)



-- my model


type alias Model =
    { directory : Directory
    , fileContent : FileContent
    , inputContent : InputContent
    }



-- my directory type for the tabs (i'll have 2)


type Directory
    = HomePage
    | InputStringPage
    | UploadTextFilePage


type alias InputContent =
    { text : Maybe String
    , tupleList : Maybe (List ( String, Int ))
    }


type alias FileContent =
    { file : Maybe File
    , fileText : Maybe String
    , tupleList : Maybe (List ( String, Int ))
    , showingFileContents : Bool
    }
