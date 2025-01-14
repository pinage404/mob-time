module Main exposing (..)

import Browser
import Browser.Navigation as Nav
import Html exposing (Html, button, div, h2, text)
import Html.Attributes exposing (class, id)
import Html.Events exposing (onClick)
import Js.Commands
import Js.Events
import Js.EventsMapping as EventsMapping exposing (EventsMapping)
import Lib.BatchMsg
import Lib.DocumentExtras
import Lib.Icons.Ion
import Lib.Toaster as Toaster exposing (Toasts)
import Lib.UpdateResult as UpdateResult exposing (UpdateResult)
import Pages.Login
import Pages.Mob.Main
import Routing
import Task
import Time
import Url
import UserPreferences



-- MAIN


main : Program UserPreferences.Model Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlChange = UrlChanged
        , onUrlRequest = LinkClicked
        }



-- MODEL


type PageModel
    = LoginModel Pages.Login.Model
    | MobModel Pages.Mob.Main.Model


type alias Model =
    { key : Nav.Key
    , url : Url.Url
    , page : PageModel
    , preferences : UserPreferences.Model
    , toasts : Toasts
    , displayModal : Bool
    }


init : UserPreferences.Model -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init preferences url key =
    let
        ( page, pageCommand ) =
            loadPage url preferences
    in
    ( { key = key
      , url = url
      , page = page
      , preferences = preferences
      , toasts = []
      , displayModal =
            case page of
                LoginModel _ ->
                    False

                MobModel _ ->
                    True
      }
    , Cmd.batch
        [ Task.perform TimePassed Time.now
        , Js.Commands.send <| Js.Commands.ChangeVolume preferences.volume
        , pageCommand
        ]
    )


loadPage : Url.Url -> UserPreferences.Model -> ( PageModel, Cmd Msg )
loadPage url preferences =
    case Routing.toPage url of
        Routing.Login ->
            Pages.Login.init
                |> Tuple.mapBoth
                    LoginModel
                    (Cmd.map GotLoginMsg)

        Routing.Mob mobName ->
            Pages.Mob.Main.init mobName preferences
                |> Tuple.mapBoth
                    MobModel
                    (Cmd.map GotMobMsg)



-- UPDATE


type Msg
    = LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | TimePassed Time.Posix
    | GotMobMsg Pages.Mob.Main.Msg
    | GotLoginMsg Pages.Login.Msg
    | GotToastMsg Toaster.Msg
    | Batch (List Msg)
    | HideModal
    | SocketDisconnected


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case ( msg, model.page ) of
        ( LinkClicked urlRequest, _ ) ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.key (Url.toString url) )

                Browser.External href ->
                    ( model, Nav.load href )

        ( UrlChanged url, _ ) ->
            loadPage url model.preferences
                |> Tuple.mapFirst (\page -> { model | page = page, url = url })

        ( GotLoginMsg subMsg, LoginModel subModel ) ->
            Pages.Login.update subModel subMsg model.key
                |> UpdateResult.map LoginModel GotLoginMsg
                |> handleToasts model
                |> toElm model

        ( GotMobMsg subMsg, MobModel subModel ) ->
            Pages.Mob.Main.update subMsg subModel
                |> UpdateResult.map MobModel GotMobMsg
                |> handleToasts model
                |> toElm model

        ( TimePassed now, MobModel subModel ) ->
            Pages.Mob.Main.timePassed now subModel
                |> Tuple.mapBoth
                    (\mob -> { model | page = MobModel mob })
                    (Cmd.map GotMobMsg)

        ( GotToastMsg subMsg, _ ) ->
            Toaster.update subMsg model.toasts
                |> Tuple.mapBoth
                    (\toasts -> { model | toasts = toasts })
                    (Cmd.map GotToastMsg)

        ( Batch messages, _ ) ->
            Lib.BatchMsg.update messages model update

        ( HideModal, _ ) ->
            ( { model | displayModal = False }
            , Cmd.none
            )

        ( SocketDisconnected, _ ) ->
            toast socketDisconnectedToast model

        _ ->
            ( model, Cmd.none )


toElm : Model -> UpdateResult PageModel Msg -> ( Model, Cmd Msg )
toElm model updateResult =
    ( { model | page = updateResult.model, toasts = updateResult.toasts }, updateResult.command )


handleToasts : Model -> UpdateResult PageModel Msg -> UpdateResult PageModel Msg
handleToasts model result =
    let
        ( allToasts, toastCommands ) =
            Toaster.add result.toasts model.toasts

        command =
            toastCommands
                |> List.map (Cmd.map GotToastMsg)
                |> (::) result.command
                |> Cmd.batch
    in
    UpdateResult result.model command allToasts


toast : Toaster.Toast -> Model -> ( Model, Cmd Msg )
toast toToast model =
    let
        ( toasts, commands ) =
            Toaster.add [ toToast ] model.toasts
    in
    ( { model | toasts = toasts }
    , commands
        |> List.map (Cmd.map GotToastMsg)
        |> Cmd.batch
    )


socketDisconnectedToast =
    Toaster.keepOn <| Toaster.error "You were disconnected from the server. Please refresh the page to login again."



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.batch
        [ Pages.Mob.Main.subscriptions |> Sub.map GotMobMsg
        , Time.every 500 TimePassed
        , Js.Events.events (dispatch jsEventsMapping)
        ]


dispatch : EventsMapping Msg -> Js.Events.Event -> Msg
dispatch mapping event =
    Batch <| EventsMapping.dispatch event mapping


jsEventsMapping : EventsMapping Msg
jsEventsMapping =
    EventsMapping.batch
        [ EventsMapping.map GotMobMsg Pages.Mob.Main.jsEventMapping
        , EventsMapping.map GotToastMsg Toaster.jsEventMapping
        , EventsMapping.create [ Js.Events.EventMessage "SocketDisconnected" (\_ -> SocketDisconnected) ]
        ]



-- VIEW


view : Model -> Browser.Document Msg
view model =
    let
        doc =
            case model.page of
                LoginModel sub ->
                    Pages.Login.view sub
                        |> Lib.DocumentExtras.map GotLoginMsg

                MobModel sub ->
                    Pages.Mob.Main.view sub model.url
                        |> Lib.DocumentExtras.map GotMobMsg
    in
    { title = doc.title
    , body =
        doc.body
            ++ soundModal model
            ++ [ Toaster.view model.toasts |> Html.map GotToastMsg ]
    }


soundModal : Model -> List (Html Msg)
soundModal model =
    if model.displayModal then
        [ div
            [ id "modal-container", onClick HideModal ]
            [ div [ id "modal" ]
                [ h2 [] [ text "Welcome to Mobtime !" ]
                , button
                    [ class "labelled-icon-button"
                    , onClick <| HideModal
                    ]
                    [ Lib.Icons.Ion.paperAirplane
                    , text "Let's go!"
                    ]
                ]
            ]
        ]

    else
        []
