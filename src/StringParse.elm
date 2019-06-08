-- this is the module which parses the input strings, and returns the tupes which allows me to figure out the ranking of the words.


module StringParse exposing (Datum, toDuplicateTuples, toTypeAlias)

import List exposing (filter, head, length, map, reverse, sort, sortBy, take)
import String exposing (replace, split, trim)
import String.Extra exposing (decapitalize)



-- toDuplicateTuples splits off a string into a tuple with a word and its occurence (good for graphs rip I can't get graphs to work)


toDuplicateTuples : Maybe String -> Maybe (List ( String, Int ))
toDuplicateTuples string =
    case string of
        Nothing ->
            Nothing

        Just s ->
            let
                -- splits the string then sorts it alphabetically
                stringList =
                    s
                        |> replace "\n" " "
                        |> removePunctuation
                        |> split " "
                        |> tame
                        |> sort
            in
            groupDuplicates stringList
                |> toOccurenceTuple
                |> Just


type alias Datum =
    { word : String
    , occurence : Int
    }



-- this is useful for lists. When you are displaying your data and have to use type aliases it is easier to use those tham use tuples.


toTypeAlias : List ( String, Int ) -> List Datum
toTypeAlias list =
    let
        helper ( string, int ) =
            Datum string int
    in
    -- i basically map over the duplicate tuple array and make them all lists of data. Then i sory by occurence, then reverse so the highest is at the top
    map
        helper
        list
        |> sortBy .occurence
        |> reverse
        -- LOL WE'RE CUTTING IT TO 1000 MEMBERS BECAUSE ELM-UI'S TABLE CANNOT HANDLE MORE THAN 1000 ELEMENTS LOL
        |> take 999



-- groupDuplicates groups up duplicates into their own lists.


groupDuplicates : List a -> List (List a)
groupDuplicates xs =
    case xs of
        [] ->
            []

        y :: ys ->
            group_helper y [ y ] ys


group_helper : a -> List a -> List a -> List (List a)
group_helper v run xs =
    case xs of
        [] ->
            [ run ]

        y :: ys ->
            if y == v then
                group_helper y (y :: run) ys

            else
                run :: group_helper y [ y ] ys


toOccurenceTuple : List (List a) -> List ( a, Int )
toOccurenceTuple list =
    let
        occurenceHelper xs =
            ( head xs, length xs )
    in
    -- because the head function returns a Maybe a, I have to use this "return nothing" for the types to work out.
    map
        occurenceHelper
        list
        |> removeNothings


removeNothings : List ( Maybe a, Int ) -> List ( a, Int )
removeNothings xs =
    case xs of
        [] ->
            []

        ( Nothing, len ) :: rest ->
            removeNothings rest

        ( Just y, len ) :: rest ->
            ( y, len ) :: removeNothings rest



-- literally removes punctuation lol


removePunctuation : String -> String
removePunctuation string =
    string
        |> replace "." ""
        |> replace "," ""
        |> replace ":" ""
        |> replace ";" ""
        |> replace "!" ""
        |> replace "(" ""
        |> replace ")" ""
        |> replace "{" ""
        |> replace "}" ""
        |> replace "[" ""
        |> replace "]" ""
        |> replace "?" ""
        |> replace "-" ""
        |> replace "_" ""



-- removes line breaks, white spaces, decapitalizes, etc. from ever element in the list.


tame : List String -> List String
tame list =
    let
        helper string =
            string
                |> trim
                |> decapitalize
    in
    map
        helper
        list
        -- idk somehow "" enters into the list so I have to explicitly remove them
        |> filter (\x -> x /= "")
