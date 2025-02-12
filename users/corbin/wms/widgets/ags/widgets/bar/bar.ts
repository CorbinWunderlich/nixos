import app from "resource:///com/github/Aylur/ags/app.js"
import battery from "resource:///com/github/Aylur/ags/service/battery.js"
import bluetooth from "resource:///com/github/Aylur/ags/service/bluetooth.js"
import hyprland from "resource:///com/github/Aylur/ags/service/hyprland.js"
import network from "resource:///com/github/Aylur/ags/service/network.js"
import { execAsync } from "resource:///com/github/Aylur/ags/utils.js"
import { Variable } from "resource:///com/github/Aylur/ags/variable.js"
import { Box, Button, CenterBox, EventBox, Icon, Label, Window } from "resource:///com/github/Aylur/ags/widget.js"

const workspaceDispatcher = ws => execAsync(`hyprctl dispatch workspace ${ws}`)

const monitorOneWorkspaces = () => EventBox({
    className: "workspaces",
    vpack: "center",

    onScrollUp: () => workspaceDispatcher("+1"),
    onScrollDown: () => workspaceDispatcher("-1"),

    child: Box({
        vertical: false,

        children: Array.from({ length: 20 }, (_, i) => i + 1).map(i => Button({
            setup: button => button.name = i.toString(),
            className: "workspace",

            tooltipText: `Workspace #${(i - 10).toString()}`,

            onClicked: () => workspaceDispatcher(i),

            child: Label("")
        })),

        connections: [[hyprland, self => self.children.forEach(button => {
            button.visible = (hyprland.workspaces.some(ws => ws.id === Number.parseInt(button.name) && Number.parseInt(button.name) > 10))
            button.toggleClassName("selected-workspace", hyprland.active.workspace.id === Number.parseInt(button.name))
        })]]
    })
})

const monitorTwoWorkspaces = () => EventBox({
    className: "workspaces",
    vpack: "center",

    onScrollUp: () => workspaceDispatcher("+1"),
    onScrollDown: () => workspaceDispatcher("-1"),

    child: Box({
        vertical: false,

        children: Array.from({ length: 10 }, (_, i) => i + 1).map(i => Button({
            setup: button => button.name = i.toString(),
            className: "workspace",

            tooltipText: `Workspace #${i.toString()}`,

            onClicked: () => workspaceDispatcher(i),

            child: Label("")
        })),

        connections: [[hyprland, self => self.children.forEach(button => {
            button.visible = hyprland.workspaces.some(ws => ws.id === Number.parseInt(button.name))
            button.toggleClassName("selected-workspace", hyprland.active.workspace.id === Number.parseInt(button.name))
        })]]
    })
})

const time = new Variable("0:0:0", {
    poll: [100, "date +%H:%M:%S"]
})

const timeLabel = () => Label({
    className: "time",

    label: time.bind(),

    connections: [[100, self => {
        const weekdays = ["Sunday", "Monday", "Tuesday", " Wednesday", "Thursday", "Friday", "Saturday"]
        const months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
        const today = new Date()

        self.tooltipText = `It is ${weekdays[today.getDay()]}, ${months[today.getMonth()]} ${today.getDate()}`
    }]]
})

function getWifiLabel() {
    if (network.primary === "wired") {
        if (network.wired?.internet == "connected") return "󰈁"
        if (network.wired?.internet == "disconnected") return "󰈂"
    }

    if (network.primary === "wifi") {
        if (network.wifi?.strength <= 10) return "󰤯"
        if (network.wifi?.strength <= 25) return "󰤟"
        if (network.wifi?.strength <= 50) return "󰤢"
        if (network.wifi?.strength <= 75) return "󰤢"

        return "󰤨"
    }

    return "󰈁"
}

const wifiLabel = () => Label({
    classNames: ["icon", "wifi"],

    connections: [[network, self => {
        self.label = getWifiLabel()
        if (network.primary == "wifi") self.tooltipText = `WiFi is at ${network.wifi?.strength}% strength`
        if (network.primary == "wired") self.tooltipText = `EtherNet is ${network.wired?.internet}`
    }]]
})

function getBluetoothLabel() {
    if (bluetooth.enabled) return "󰂯"
    else return "󰂲"
}

const bluetoothIcon = () => Label({
    classNames: ["icon", "bluetooth"],

    connections: [[bluetooth, self => {
        self.label = getBluetoothLabel()
        self.tooltipText = `Connected to ${bluetooth.devices.length} device${bluetooth.devices.length === 1 ? "" : "s"}`
    }]]
})

function getBatteryLabel() {
    if (battery.charging) {
        if (battery.percent === 100) return "󰂅"
        if (battery.percent >= 90) return "󰂋"
        if (battery.percent >= 80) return "󰂊"
        if (battery.percent >= 70) return "󰢞"
        if (battery.percent >= 60) return "󰂉"
        if (battery.percent >= 50) return "󰢝"
        if (battery.percent >= 40) return "󰂈"
        if (battery.percent >= 30) return "󰂇"
        if (battery.percent >= 20) return "󰂆"
        if (battery.percent >= 10) return "󰢜"

        return "󰢟"
    }

    if (battery.percent === 100) return "󰁹"
    if (battery.percent >= 90) return "󰂂"
    if (battery.percent >= 80) return "󰂁"
    if (battery.percent >= 70) return "󰂀"
    if (battery.percent >= 60) return "󰁿"
    if (battery.percent >= 50) return "󰁿"
    if (battery.percent >= 40) return "󰁽"
    if (battery.percent >= 30) return "󰁼"
    if (battery.percent >= 20) return "󰁻"
    if (battery.percent >= 10) return "󰁺"

    return "󰂎"
}

function secondsToHms(durationSeconds: number) {
    var hours = Math.floor(durationSeconds / 3600);
    var minutes = Math.floor(durationSeconds % 3600 / 60);
    var seconds = Math.floor(durationSeconds % 3600 % 60);

    var hDisplay = hours > 0 ? hours + (hours == 1 ? " hour and " : " hours and ") : "";
    var mDisplay = minutes > 0 ? minutes + (minutes == 1 ? " minute " : " minutes ") : "";
    var sDisplay = seconds > 0 ? seconds + (seconds == 1 ? " second" : " seconds") : "";
    return hDisplay + mDisplay;
}

const batteryIcon = () => Label({
    className: "icon",

    connections: [[battery, self => {
        self.label = getBatteryLabel()
        self.tooltipText = battery.charging ? `${battery.timeRemaining} until charged` : `${secondsToHms(battery.timeRemaining)}until empty`
    }]],
})

const batteryLabel = () => Label({
    className: "battery",
    hpack: "end",

    connections: [[battery, self => {
        self.label = battery.percent + "%"
        self.tooltipText = battery.charging ? `${secondsToHms(battery.timeRemaining)} until charged` : `${secondsToHms(battery.timeRemaining)}until empty`
    }]]
})

const batteryContainer = () => Box({
    vertical: false,
    hpack: "end",

    children: [
        batteryIcon(),
        batteryLabel()
    ]
})

const workspaces = () => Box({
    vertical: false,
    hpack: "start",

    spacing: 8,

    children: [
        monitorOneWorkspaces(),
        monitorTwoWorkspaces(),
    ],

    css: "padding-left: 2px"
})

const end = () => Box({
    vertical: false,
    hpack: "end",

    children: [
        // Button({
        //     onClicked:() => app.toggleWindow("ags-drawer"),
        //     child: Label("JDSADSAIDISAJDOIJSAd")
        // }),
        wifiLabel(),
        bluetoothIcon()
    ]
})

const bar = (monitor = 1) => Window({
    monitor,
    name: "top-bar",

    anchor: ["top"],
    exclusivity: "exclusive",

    child: CenterBox({
        className: "top-bar-content",
        vertical: false,

        startWidget: workspaces(),
        centerWidget: timeLabel(),
        endWidget: end()
    }),
})

export default bar
