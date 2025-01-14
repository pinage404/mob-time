module Pages.Mob.Main exposing (..)

import Browser
import Browser.Events exposing (onKeyUp)
import Css exposing (height, px, width)
import Html.Styled as Html exposing (..)
import Html.Styled.Attributes exposing (class, classList, css, id, title)
import Html.Styled.Events exposing (onClick)
import Js.Commands
import Js.Events
import Js.EventsMapping as EventsMapping exposing (EventsMapping)
import Json.Decode
import Lib.Circle
import Lib.Duration as Duration exposing (DurationStringParts)
import Lib.Icons.Ion
import Lib.Konami as Konami exposing (Konami)
import Lib.UpdateResult as UpdateResult exposing (UpdateResult)
import Model.Clock as Clock exposing (ClockState(..))
import Pages.Mob.Tabs.Clocks
import Pages.Mob.Tabs.Mobbers
import Model.MobName exposing (MobName)
import Sounds
import Pages.Mob.Tabs.Sound
import Pages.Mob.Tabs.Dev
import Pages.Mob.Tabs.Home
import Pages.Mob.Tabs.Share
import Model.Events
import Model.State
import Peers.Sync.Adapter
import Peers.Sync.Core exposing (PeerId)
import Random
import Svg.Styled exposing (Svg, svg)
import Svg.Styled.Attributes as Svg
import Time
import Url
import UserPreferences



-- MODEL


type AlarmState
    = Playing
    | Stopped
    | Standby


type Tab
    = Main
    | Mobbers
    | Clock
    | Sound
    | Share
    | Dev


type alias Model =
    { name : MobName
    , shared : Model.State.State
    , mobbersSettings : Pages.Mob.Tabs.Mobbers.Model
    , clockSettings : Pages.Mob.Tabs.Clocks.Model
    , soundSettings : Pages.Mob.Tabs.Sound.Model
    , clockSync : Peers.Sync.Adapter.Model
    , alarm : AlarmState
    , now : Time.Posix
    , tab : Tab
    , dev : Bool
    , konami : Konami
    , peerId : Maybe PeerId
    }


init : MobName -> UserPreferences.Model -> ( Model, Cmd Msg )
init name preferences =
    let
        ( clockSync, clockSyncCommand ) =
            Peers.Sync.Adapter.init name
    in
    ( { name = name
      , shared = Model.State.init
      , mobbersSettings = Pages.Mob.Tabs.Mobbers.init
      , clockSettings = Pages.Mob.Tabs.Clocks.init
      , soundSettings = Pages.Mob.Tabs.Sound.init preferences.volume
      , clockSync = clockSync
      , alarm = Standby
      , now = Time.millisToPosix 0
      , tab = Main
      , dev = False
      , konami = Konami.empty
      , peerId = Nothing
      }
    , Cmd.batch
        [ Js.Commands.send <| Js.Commands.Join name
        , Cmd.map GotClockSyncMsg clockSyncCommand
        ]
    )



-- UPDATE


type Msg
    = ShareEvent Model.Events.MobEvent
    | ReceivedEvent Model.Events.Event
    | ReceivedHistory (List Model.Events.Event)
    | Start
    | StartWithAlarm  Sounds.Sound
    | StopSound
    | AlarmEnded
    | GotMainTabMsg Pages.Mob.Tabs.Home.Msg
    | GotClockSettingsMsg Pages.Mob.Tabs.Clocks.Msg
    | GotShareTabMsg Pages.Mob.Tabs.Share.Msg
    | GotMobbersSettingsMsg Pages.Mob.Tabs.Mobbers.Msg
    | GotSoundSettingsMsg Pages.Mob.Tabs.Sound.Msg
    | GotClockSyncMsg Peers.Sync.Adapter.Msg
    | SwitchTab Tab
    | KeyPressed Keystroke
    | GotSocketId PeerId


timePassed : Time.Posix -> Model -> ( Model, Cmd Msg )
timePassed now model =
    let
        timePassedResult =
            Model.State.timePassed now model.shared

        toto =
            case timePassedResult.turnEvent of
                Clock.Ended ->
                    Js.Commands.send Js.Commands.SoundAlarm

                Clock.Continued ->
                    Cmd.none
    in
    ( { model
        | alarm =
            case timePassedResult.turnEvent of
                Clock.Ended ->
                    Playing

                Clock.Continued ->
                    model.alarm
        , now = now
        , shared = timePassedResult.updated
      }
    , Cmd.batch
        [ toto
        , Js.Commands.send <| Js.Commands.ChangeTitle <| timeLeftTitle <| timeLeftString model
        ]
    )


update : Msg -> Model -> UpdateResult Model Msg
update msg model =
    case msg of
        ShareEvent event ->
            { model = model
            , command = Model.Events.sendEvent <| Model.Events.mobEventToJson event
            , toasts = []
            }

        ReceivedEvent event ->
            let
                ( shared, command ) =
                    Model.State.evolve event model.shared
            in
            { model =
                { model
                    | shared = shared
                    , alarm =
                        -- Handle alarm (command) as separate from the evolve method ?
                        case event of
                            Model.Events.Clock (Model.Events.Started _) ->
                                Stopped

                            _ ->
                                model.alarm
                }
            , command = command
            , toasts = []
            }

        ReceivedHistory eventsResults ->
            let
                ( shared, command ) =
                    Model.State.evolveMany eventsResults model.shared
            in
            { model = { model | shared = shared }
            , command = command
            , toasts = []
            }

        Start ->
            { model = model
            , command = Random.generate StartWithAlarm <| Sounds.pick model.shared.soundProfile
            , toasts = []
            }

        StartWithAlarm sound ->
            { model = model
            , command =
                Model.Events.Started
                    { time = model.now
                    , alarm = sound
                    , length =
                        Duration.div model.shared.turnLength <|
                            if model.dev then
                                20

                            else
                                1
                    }
                    |> Model.Events.Clock
                    |> Model.Events.MobEvent model.name
                    |> Model.Events.mobEventToJson
                    |> Model.Events.sendEvent
            , toasts = []
            }

        StopSound ->
            { model = { model | alarm = Stopped }
            , command = Js.Commands.send Js.Commands.StopAlarm
            , toasts = []
            }

        AlarmEnded ->
            { model = { model | alarm = Stopped }
            , command = Cmd.none
            , toasts = []
            }

        GotMainTabMsg subMsg ->
            { model = model
            , command = Pages.Mob.Tabs.Home.update subMsg |> Cmd.map GotMainTabMsg
            , toasts = []
            }

        GotMobbersSettingsMsg subMsg ->
            let
                mobbersResult =
                    Pages.Mob.Tabs.Mobbers.update subMsg model.shared.mobbers model.name model.mobbersSettings
            in
            { model =
                { model
                    | mobbersSettings = mobbersResult.model
                }
            , command = Cmd.map GotMobbersSettingsMsg mobbersResult.command
            , toasts = mobbersResult.toasts
            }

        SwitchTab tab ->
            { model = { model | tab = tab }
            , command = Cmd.none
            , toasts = []
            }

        GotShareTabMsg subMsg ->
            { model = model
            , command = Pages.Mob.Tabs.Share.update subMsg |> Cmd.map GotShareTabMsg
            , toasts = []
            }

        GotClockSettingsMsg subMsg ->
            let
                ( clockSettings, command ) =
                    Pages.Mob.Tabs.Clocks.update subMsg model.clockSettings model.name
            in
            { model = { model | clockSettings = clockSettings }
            , command = Cmd.map GotClockSettingsMsg command
            , toasts = []
            }

        GotSoundSettingsMsg subMsg ->
            let
                ( soundSettings, command ) =
                    Pages.Mob.Tabs.Sound.update subMsg model.soundSettings
            in
            { model = { model | soundSettings = soundSettings }
            , command = Cmd.map GotSoundSettingsMsg command
            , toasts = []
            }

        KeyPressed { key } ->
            { model =
                { model
                    | dev = xor model.dev <| Konami.isActivated model.konami
                    , konami = Konami.add key model.konami
                }
            , command = Cmd.none
            , toasts = []
            }

        GotClockSyncMsg sub ->
            Peers.Sync.Adapter.update sub model.clockSync model.now
                |> UpdateResult.map
                    (\m -> { model | clockSync = m })
                    GotClockSyncMsg

        GotSocketId peerId ->
            UpdateResult.fromModel { model | peerId = Just peerId }



-- SUBSCRIPTIONS


type alias Keystroke =
    { key : String
    , ctrl : Bool
    , alt : Bool
    , shift : Bool
    }


subscriptions : Sub Msg
subscriptions =
    Sub.batch
        [ Model.Events.receiveOne <| Model.Events.fromJson >> ReceivedEvent
        , Model.Events.receiveHistory <| List.map Model.Events.fromJson >> ReceivedHistory
        , Sub.map GotClockSyncMsg Peers.Sync.Adapter.subscriptions
        , onKeyUp <|
            Json.Decode.map KeyPressed <|
                Json.Decode.map4 Keystroke
                    (Json.Decode.field "key" Json.Decode.string)
                    (Json.Decode.field "ctrlKey" Json.Decode.bool)
                    (Json.Decode.field "altKey" Json.Decode.bool)
                    (Json.Decode.field "shiftKey" Json.Decode.bool)
        ]


jsEventMapping : EventsMapping Msg
jsEventMapping =
    EventsMapping.batch
        [ EventsMapping.create <|
            [ Js.Events.EventMessage "AlarmEnded" (\_ -> AlarmEnded)
            , Js.Events.EventMessage "GotSocketId" GotSocketId
            ]
        , EventsMapping.map GotClockSyncMsg Peers.Sync.Adapter.jsEventMapping
        ]



-- VIEW


view : Model -> Url.Url -> Browser.Document Msg
view model url =
    let
        action =
            detectAction model
    in
    { title = timeLeftTitle action.timeLeft
    , body = body model url action |> List.map toUnstyled
    }


body : Model -> Url.Url -> ActionDescription -> List (Html Msg)
body model url action =
    let
        outerRadiant =
            84

        offset =
            5

        pomodoroStroke =
            8

        mainStroke =
            14

        totalWidth =
            outerRadiant * 2 + (pomodoroStroke + mainStroke) / 2

        pomodoroCircle =
            Lib.Circle.Circle
                outerRadiant
                (Lib.Circle.Coordinates (outerRadiant + offset) (outerRadiant + offset))
                (Lib.Circle.Stroke pomodoroStroke "#999")

        mobCircle =
            Lib.Circle.inside pomodoroCircle <| Lib.Circle.Stroke mainStroke "#666"
    in
    [ div [ class "container" ]
        [ header []
            [ section []
                [ svg
                    [ id "circles"
                    , Svg.width <| String.fromFloat totalWidth
                    , Svg.height <| String.fromFloat totalWidth
                    ]
                    (Lib.Circle.draw pomodoroCircle (Clock.ratio model.now model.shared.pomodoro)
                        ++ Lib.Circle.draw mobCircle (Clock.ratio model.now model.shared.clock)
                    )
                , button
                    [ id "action"
                    , class action.class
                    , onClick action.message
                    , css
                        [ width (px totalWidth)
                        , height (px totalWidth)
                        ]
                    ]
                    [ action.icon
                    , span [ id "time-left" ] (action.timeLeft |> List.map (\a -> span [] [ text a ]))
                    ]
                ]
            ]
        , nav []
            ([ button
                [ onClick <| SwitchTab Main
                , classList [ ( "active", model.tab == Main ) ]
                , title "Home"
                ]
                [ Lib.Icons.Ion.home |> fromUnstyled ]
             , button
                [ onClick <| SwitchTab Clock
                , classList [ ( "active", model.tab == Clock ) ]
                , title "Clock Settings"
                ]
                [ Lib.Icons.Ion.clock |> fromUnstyled ]
             , button
                [ onClick <| SwitchTab Mobbers
                , classList [ ( "active", model.tab == Mobbers ) ]
                , title "Mobbers"
                ]
                [ Lib.Icons.Ion.people |> fromUnstyled ]
             , button
                [ onClick <| SwitchTab Sound
                , classList [ ( "active", model.tab == Sound ) ]
                , title "Sound Settings"
                ]
                [ Lib.Icons.Ion.sound |> fromUnstyled ]
             , button
                [ onClick <| SwitchTab Share
                , classList [ ( "active", model.tab == Share ) ]
                , title "Share"
                ]
                [ Lib.Icons.Ion.share |> fromUnstyled ]
             ]
                ++ (if model.dev then
                        [ button
                            [ onClick <| SwitchTab Dev
                            , classList [ ( "active", model.tab == Dev ) ]
                            , title "Dev"
                            ]
                            [ Lib.Icons.Ion.code |> fromUnstyled ]
                        ]

                    else
                        []
                   )
            )
        , case model.tab of
            Main ->
                Pages.Mob.Tabs.Home.view model.name url model.shared.mobbers
                    |> Html.fromUnstyled
                    |> Html.map GotMainTabMsg

            Clock ->
                Pages.Mob.Tabs.Clocks.view model.clockSettings model.now model.shared
                    |> Html.fromUnstyled
                    |> Html.map GotClockSettingsMsg

            Mobbers ->
                Pages.Mob.Tabs.Mobbers.view model.shared.mobbers model.mobbersSettings
                    |> Html.fromUnstyled
                    |> Html.map GotMobbersSettingsMsg

            Sound ->
                Pages.Mob.Tabs.Sound.view model.soundSettings model.name model.shared.soundProfile
                    |> Html.fromUnstyled
                    |> Html.map GotSoundSettingsMsg

            Share ->
                Pages.Mob.Tabs.Share.view model.name url
                    |> Html.fromUnstyled
                    |> Html.map GotShareTabMsg

            Dev ->
                Pages.Mob.Tabs.Dev.view model.clockSync
        ]
    ]


type alias ActionDescription =
    { icon : Svg Msg
    , message : Msg
    , timeLeft : DurationStringParts
    , class : String
    }


detectAction : Model -> ActionDescription
detectAction model =
    let
        timeLeft =
            timeLeftString model
    in
    case ( model.alarm, model.shared.clock, model.shared.pomodoro ) of
        ( Playing, _, _ ) ->
            { icon = Lib.Icons.Ion.mute |> fromUnstyled
            , message = StopSound
            , class = ""
            , timeLeft = timeLeft
            }

        ( _, On _, _ ) ->
            { icon = Lib.Icons.Ion.stop |> fromUnstyled
            , message =
                Model.Events.Clock Model.Events.Stopped
                    |> Model.Events.MobEvent model.name
                    |> ShareEvent
            , class = "on"
            , timeLeft = timeLeft
            }

        ( _, Off, On pomodoro ) ->
            if Duration.secondsBetween model.now pomodoro.end <= 0 then
                { icon = Lib.Icons.Ion.coffee |> fromUnstyled
                , message =
                    Model.Events.PomodoroStopped
                        |> Model.Events.MobEvent model.name
                        |> ShareEvent
                , class = ""
                , timeLeft = timeLeft
                }

            else
                { icon = Lib.Icons.Ion.play |> fromUnstyled
                , message = Start
                , class = ""
                , timeLeft = timeLeft
                }

        ( _, Off, _ ) ->
            { icon = Lib.Icons.Ion.play |> fromUnstyled
            , message = Start
            , class = ""
            , timeLeft = timeLeft
            }


timeLeftString : Model -> DurationStringParts
timeLeftString model =
    case model.shared.clock of
        On on ->
            Duration.between model.now on.end
                |> (if model.clockSettings.displaySeconds then
                        Duration.toLongString

                    else
                        Duration.toShortString
                   )

        _ ->
            []


timeLeftTitle : DurationStringParts -> String
timeLeftTitle action =
    case action of
        [] ->
            "Mob Time"

        _ ->
            String.join " " action ++ " | " ++ "Mob Time"
