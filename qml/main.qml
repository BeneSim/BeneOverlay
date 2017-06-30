/* Copyright (C) 2017 Benjamin Isbarn.

   This file is part of BeneOverlay.

   BeneOverlay is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   BeneOverlay is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with BeneOverlay.  If not, see <http://www.gnu.org/licenses/>.
*/

import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.1
import QtQuick.Layouts 1.3

import org.benesim.types 1.0

import "js/showdown.js" as Showdown


ApplicationWindow {
    id: root
    visible: true
    width: 600
    minimumWidth: main_grid_layout.Layout.minimumWidth
    height: 750
    minimumHeight: main_grid_layout.Layout.minimumHeight
    title: "BeneOverlay v" + VERSION_STRING

    Dialog {
        id: dialog

        property alias text: dialog_message.text
        property string download_url

        width: 400
        height: 400
        standardButtons: Dialog.Open
        modal: true
        x: (parent.width - dialog.width)/2
        y: (parent.height - dialog.height)/2

        onAccepted: Qt.openUrlExternally(download_url)

        Flickable {
            id: dialog_flickable

            anchors.fill: parent
            contentHeight: dialog_message.height
            clip: true

            ScrollBar.vertical: ScrollBar {
                id: scroll_bar
                policy: dialog_flickable.contentHeight > dialog_flickable.height? ScrollBar.AlwaysOn : ScrollBar.AlwaysOff
            }

            Text {
                id: dialog_message

                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.rightMargin: scroll_bar.width

                wrapMode: Text.WordWrap
                textFormat: Text.RichText
                onLinkActivated: Qt.openUrlExternally(link)
            }
        }
    }

    UpdateManager {
        id: update_manager

        user: "benesim"
        repo: "beneoverlay"

        onUpdateAvailable: {
            dialog.title = "Version " + version_string + " available!";
            dialog.text = "<style>a { color: " + Material.accent + "; }</style>" + new Showdown.showdown.Converter().makeHtml(body);
            dialog.download_url = download_url;
            dialog.open();
        }
        Component.onCompleted: update_manager.checkForUpdate()
    }

    GridLayout {
        id: main_grid_layout

        anchors.fill: parent
        columnSpacing: 0
        rowSpacing: 0
        columns: 2
        rows: 2

        Rectangle {
            id: menu

            property int index: 0

            width: 180
            color: "#263238"

            Layout.rowSpan: 2
            Layout.fillHeight: true
            Layout.minimumHeight: menu_column_layout.Layout.minimumHeight

            ButtonGroup {
                id: menu_button_group
            }

            ColumnLayout {
                id: menu_column_layout

                anchors {left: parent.left; top: parent.top; right: parent.right; leftMargin: 10; topMargin: 10}
                spacing: 0

                Image {
                    source: "qrc:/images/beneoverlay.png"
                    Layout.bottomMargin: 10
                }

                BOMenuItem {
                    label: "Flight"
                    checked: true
                    onCheckedChanged: if (checked) menu.index = 0

                    ButtonGroup.group: menu_button_group
                    Layout.fillWidth: true
                }

                BOMenuItem {
                    label: "General"
                    onCheckedChanged: if (checked) menu.index = 1

                    ButtonGroup.group: menu_button_group
                    Layout.fillWidth: true
                }

                BOMenuItem {
                    label: "Widgets"
                    onCheckedChanged: if (checked) menu.index = 2

                    ButtonGroup.group: menu_button_group
                    Layout.fillWidth: true
                }

                ColumnLayout {

                    Layout.leftMargin: 10
                    spacing: 0

                    BOMenuItem {
                        label: "Callsign"
                        onCheckedChanged: if (checked) menu.index = 3

                        ButtonGroup.group: menu_button_group
                        Layout.fillWidth: true
                    }

                    BOMenuItem {
                        label: "Network"
                        onCheckedChanged: if (checked) menu.index = 4

                        ButtonGroup.group: menu_button_group
                        Layout.fillWidth: true
                    }

                    BOMenuItem {
                        label: "Speed"
                        onCheckedChanged: if (checked) menu.index = 5

                        ButtonGroup.group: menu_button_group
                        Layout.fillWidth: true
                    }

                    BOMenuItem {
                        label: "Heading"
                        onCheckedChanged: if (checked) menu.index = 6

                        ButtonGroup.group: menu_button_group
                        Layout.fillWidth: true
                    }

                    BOMenuItem {
                        label: "Altitude"
                        onCheckedChanged: if (checked) menu.index = 7

                        ButtonGroup.group: menu_button_group
                        Layout.fillWidth: true
                    }

                    BOMenuItem {
                        label: "Wind"
                        onCheckedChanged: if (checked) menu.index = 8

                        ButtonGroup.group: menu_button_group
                        Layout.fillWidth: true
                    }

                    BOMenuItem {
                        label: "Temperature"
                        onCheckedChanged: if (checked) menu.index = 9

                        ButtonGroup.group: menu_button_group
                        Layout.fillWidth: true
                    }

                    BOMenuItem {
                        label: "Performance"
                        onCheckedChanged: if (checked) menu.index = 10

                        ButtonGroup.group: menu_button_group
                        Layout.fillWidth: true
                    }
                }

                BOMenuItem {
                    label: "Progress"
                    onCheckedChanged: if (checked) menu.index = 11

                    ButtonGroup.group: menu_button_group
                    Layout.fillWidth: true
                }

                BOMenuItem {
                    label: "Landing"
                    onCheckedChanged: if (checked) menu.index = 12

                    ButtonGroup.group: menu_button_group
                    Layout.fillWidth: true
                }

                ColumnLayout {

                    Layout.leftMargin: 10
                    spacing: 0

                    BOMenuItem {
                        label: "Title"
                        onCheckedChanged: if (checked) menu.index = 13

                        ButtonGroup.group: menu_button_group
                        Layout.fillWidth: true
                    }

                    BOMenuItem {
                        label: "Rate"
                        onCheckedChanged: if (checked) menu.index = 14

                        ButtonGroup.group: menu_button_group
                        Layout.fillWidth: true
                    }

                    BOMenuItem {
                        label: "Speed"
                        onCheckedChanged: if (checked) menu.index = 15

                        ButtonGroup.group: menu_button_group
                        Layout.fillWidth: true
                    }

                    BOMenuItem {
                        label: "Attitude"
                        onCheckedChanged: if (checked) menu.index = 16

                        ButtonGroup.group: menu_button_group
                        Layout.fillWidth: true
                    }
                }
            }
        }

        StackLayout {
            currentIndex: menu.index

            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.rowSpan: notification_rectangle.visible? 1 : 2

            BOGroupBox {
                label: "Flight Settings"

                GridLayout {
                    anchors {left: parent.left; top: parent.top; right: parent.right}
                    columns: 2

                    columnSpacing: 32
                    rowSpacing: 32

                    BOTextField {
                        label: "Departure ICAO"
                        placeholderText: "EDDT"
                        data_ref: data_ref_manager.getDataRef("flight/departure_icao")
                        Layout.fillWidth: true
                    }

                    BOTextField {
                        label: "Arrival ICAO"
                        placeholderText: "LSZH"
                        data_ref: data_ref_manager.getDataRef("flight/arrival_icao")
                        Layout.fillWidth: true
                    }

                    BOTextField {
                        label: "Route"
                        placeholderText: "BRANE Q201 BUREL UM736 TABAT UL87 ANELA UN869 TEDGO T724 RILAX"
                        data_ref: data_ref_manager.getDataRef("flight/route")
                        Layout.columnSpan: 2
                        Layout.fillWidth: true
                    }

                    BOTextField {
                        label: "Airline"
                        placeholderText: "Global Wings"
                        data_ref: data_ref_manager.getDataRef("flight/airline")
                        Layout.fillWidth: true
                    }

                    BOTextField {
                        label: "Airline ICAO"
                        placeholderText: "GLW"
                        data_ref: data_ref_manager.getDataRef("flight/airline_icao")
                        Layout.fillWidth: true
                    }

                    BOTextField {
                        label: "Flight Number"
                        placeholderText: "568A"
                        data_ref: data_ref_manager.getDataRef("flight/flight_number")
                        Layout.fillWidth: true
                    }

                    BOTextField {
                        label: "Network"
                        placeholderText: "IVAO"
                        data_ref: data_ref_manager.getDataRef("flight/network")
                        Layout.fillWidth: true
                    }

                    BOTextField {
                        label: "Cruise Altitude"
                        placeholderText: "12000"
                        data_ref: data_ref_manager.getDataRef("flight/cruise_altitude")
                        Layout.fillWidth: true
                        validator: IntValidator {
                            bottom: 0
                        }
                    }

                    BOTextField {
                        label: "Max IAS"
                        placeholderText: "300"
                        data_ref: data_ref_manager.getDataRef("flight/max_ias")
                        Layout.fillWidth: true
                        validator: IntValidator {
                            bottom: 0
                        }
                    }

                    BOTextField {
                        label: "Transition Altitude"
                        placeholderText: "5000"
                        data_ref: data_ref_manager.getDataRef("flight/transition_altitude")
                        Layout.fillWidth: true
                        validator: IntValidator {
                            bottom: 0
                        }
                    }

                    BOTextField {
                        label: "Aircraft ICAO"
                        placeholderText: "B738"
                        data_ref: data_ref_manager.getDataRef("flight/aircraft_icao")
                        Layout.fillWidth: true
                    }
                }
            }

            BOGroupBox {
                anchors.fill: parent
                label: "General Settings"

                GridLayout {
                    anchors {left: parent.left; top: parent.top; right: parent.right}
                    columns: 2
                    columnSpacing: 16
                    rowSpacing: 16

                    BOSpinBox {
                        label: "Data Rate"
                        from: 1
                        to: 60
                        data_ref: data_ref_manager.getDataRef("global/data_rate")

                        Layout.columnSpan: 2
                    }

                    BOSwitch {
                        label: "Icons Enabled"
                        description: "Enable icons for the widgets"
                        data_ref: data_ref_manager.getDataRef("global/icon_enabled")

                        Layout.columnSpan: 2
                    }

                    BOSpinBox {
                        label: "Icon Size"
                        data_ref: data_ref_manager.getDataRef("global/icon_size")
                        from: 0

                        Layout.columnSpan: 2
                    }

                    BOColorSelector {
                        label: "Primary Color"
                        data_ref: data_ref_manager.getDataRef("global/primary_color")

                        Layout.fillWidth: false
                    }

                    BOColorSelector {
                        label: "Secondary Color"
                        data_ref: data_ref_manager.getDataRef("global/secondary_color")

                        Layout.fillWidth: true
                    }

                    BOFontSelector {
                        label: "Primary Font"
                        data_ref: data_ref_manager.getDataRef("global/primary_font")

                        Layout.fillWidth: false
                    }

                    BOFontSelector {
                        label: "Secondary Font"
                        data_ref: data_ref_manager.getDataRef("global/secondary_font")

                        Layout.fillWidth: true
                    }
                }
            }

            BOGroupBox {
                label: "Widgets Settings"

                ColumnLayout {
                    anchors {left: parent.left; top: parent.top; right: parent.right}
                    spacing: 16

                    BOSwitch {
                        label: "Callsign Enabled"
                        description: "Enable Callsign widget"
                        data_ref: data_ref_manager.getDataRef("widget/callsign/enabled")
                    }

                    BOSwitch {
                        label: "Network Enabled"
                        description: "Enable Network widget"
                        data_ref: data_ref_manager.getDataRef("widget/network/enabled")
                    }

                    BOSwitch {
                        label: "Speed Enabled"
                        description: "Enable Speed widget"
                        data_ref: data_ref_manager.getDataRef("widget/speed/enabled")
                    }

                    BOSwitch {
                        label: "Heading Enabled"
                        description: "Enable Heading widget"
                        data_ref: data_ref_manager.getDataRef("widget/heading/enabled")
                    }

                    BOSwitch {
                        label: "Altitude Enabled"
                        description: "Enable Altitude widget"
                        data_ref: data_ref_manager.getDataRef("widget/altitude/enabled")
                    }

                    BOSwitch {
                        label: "Wind Enabled"
                        description: "Enable Wind widget"
                        data_ref: data_ref_manager.getDataRef("widget/wind/enabled")
                    }

                    BOSwitch {
                        label: "Temperature Enabled"
                        description: "Enable Temperature widget"
                        data_ref: data_ref_manager.getDataRef("widget/temperature/enabled")
                    }

                    BOSwitch {
                        label: "Performance Enabled"
                        description: "Enable Performance widget"
                        data_ref: data_ref_manager.getDataRef("widget/performance/enabled")
                    }
                }
            }

            BOWidgetSettings {
                label: "Callsign Settings"
                data_ref_custom_style: data_ref_manager.getDataRef("widget/callsign/custom_style")
                data_ref_icon_enabled: data_ref_manager.getDataRef("widget/callsign/icon_enabled")
                data_ref_icon_size: data_ref_manager.getDataRef("widget/callsign/icon_size")
                data_ref_primary_color: data_ref_manager.getDataRef("widget/callsign/primary_color")
                data_ref_secondary_color: data_ref_manager.getDataRef("widget/callsign/secondary_color")
                data_ref_primary_font: data_ref_manager.getDataRef("widget/callsign/primary_font")
                data_ref_secondary_font: data_ref_manager.getDataRef("widget/callsign/secondary_font")

                BOSwitch {
                    label: "Show Callsign"
                    description: "Enable Callsign readout"
                    data_ref: data_ref_manager.getDataRef("widget/callsign/callsign_enabled")
                }
                BOSwitch {
                    label: "Show Airline"
                    description: "Enable Airline readout"
                    data_ref: data_ref_manager.getDataRef("widget/callsign/airline_enabled")
                }
            }

            BOWidgetSettings {
                label: "Network Settings"
                data_ref_custom_style: data_ref_manager.getDataRef("widget/network/custom_style")
                data_ref_icon_enabled: data_ref_manager.getDataRef("widget/network/icon_enabled")
                data_ref_icon_size: data_ref_manager.getDataRef("widget/network/icon_size")
                data_ref_primary_color: data_ref_manager.getDataRef("widget/network/primary_color")
                data_ref_secondary_color: data_ref_manager.getDataRef("widget/network/secondary_color")
                data_ref_primary_font: data_ref_manager.getDataRef("widget/network/primary_font")
                data_ref_secondary_font: data_ref_manager.getDataRef("widget/network/secondary_font")

                BOSwitch {
                    label: "Show Network"
                    description: "Enable Network readout"
                    data_ref: data_ref_manager.getDataRef("widget/network/network_enabled")
                }
                BOSwitch {
                    label: "Show Aircraft"
                    description: "Enable Aircraft readout"
                    data_ref: data_ref_manager.getDataRef("widget/network/aircraft_enabled")
                }
            }

            BOWidgetSettings {
                label: "Speed Settings"
                data_ref_custom_style: data_ref_manager.getDataRef("widget/speed/custom_style")
                data_ref_icon_enabled: data_ref_manager.getDataRef("widget/speed/icon_enabled")
                data_ref_icon_size: data_ref_manager.getDataRef("widget/speed/icon_size")
                data_ref_primary_color: data_ref_manager.getDataRef("widget/speed/primary_color")
                data_ref_secondary_color: data_ref_manager.getDataRef("widget/speed/secondary_color")
                data_ref_primary_font: data_ref_manager.getDataRef("widget/speed/primary_font")
                data_ref_secondary_font: data_ref_manager.getDataRef("widget/speed/secondary_font")

                BOSwitch {
                    label: "Show IAS"
                    description: "Enable IAS readout"
                    data_ref: data_ref_manager.getDataRef("widget/speed/ias_enabled")
                }
                BOSwitch {
                    label: "Show TAS"
                    description: "Enable TAS readout"
                    data_ref: data_ref_manager.getDataRef("widget/speed/tas_enabled")
                }
                BOSwitch {
                    label: "Show GS"
                    description: "Enable GS readout"
                    data_ref: data_ref_manager.getDataRef("widget/speed/gs_enabled")
                }
                BOSwitch {
                    label: "Show Mach"
                    description: "Enable Mach readout"
                    data_ref: data_ref_manager.getDataRef("widget/speed/mach_enabled")
                }
            }

            BOWidgetSettings {
                label: "Heading Settings"
                data_ref_custom_style: data_ref_manager.getDataRef("widget/heading/custom_style")
                data_ref_icon_enabled: data_ref_manager.getDataRef("widget/heading/icon_enabled")
                data_ref_icon_size: data_ref_manager.getDataRef("widget/heading/icon_size")
                data_ref_primary_color: data_ref_manager.getDataRef("widget/heading/primary_color")
                data_ref_secondary_color: data_ref_manager.getDataRef("widget/heading/secondary_color")
                data_ref_primary_font: data_ref_manager.getDataRef("widget/heading/primary_font")
                data_ref_secondary_font: data_ref_manager.getDataRef("widget/heading/secondary_font")

                BOSwitch {
                    id: hdg_switch

                    label: "Show HDG"
                    description: "Enable HDG readout"
                    data_ref: data_ref_manager.getDataRef("widget/heading/hdg_enabled")
                }

                BOSwitch {
                    id: trk_switch

                    label: "Show TRK"
                    description: "Enable TRK readout"
                    data_ref: data_ref_manager.getDataRef("widget/heading/trk_enabled")
                }

                BOSwitch {
                    label: "Prepend Zeros"
                    description: "Prepend zeros if HDG or TRK < 100°"
                    data_ref: data_ref_manager.getDataRef("widget/heading/prepend_zeros")
                    visible: hdg_switch.checked || trk_switch.checked
                }
            }

            BOWidgetSettings {
                label: "Altitude Settings"
                data_ref_custom_style: data_ref_manager.getDataRef("widget/altitude/custom_style")
                data_ref_icon_enabled: data_ref_manager.getDataRef("widget/altitude/icon_enabled")
                data_ref_icon_size: data_ref_manager.getDataRef("widget/altitude/icon_size")
                data_ref_primary_color: data_ref_manager.getDataRef("widget/altitude/primary_color")
                data_ref_secondary_color: data_ref_manager.getDataRef("widget/altitude/secondary_color")
                data_ref_primary_font: data_ref_manager.getDataRef("widget/altitude/primary_font")
                data_ref_secondary_font: data_ref_manager.getDataRef("widget/altitude/secondary_font")

                BOSwitch {
                    label: "Show ALT"
                    description: "Enable ALT readout"
                    data_ref: data_ref_manager.getDataRef("widget/altitude/alt_enabled")
                }

                BOSwitch {
                    label: "Show VS"
                    description: "Enable VS readout"
                    data_ref: data_ref_manager.getDataRef("widget/altitude/vs_enabled")
                }
            }

            BOWidgetSettings {
                label: "Wind Settings"
                data_ref_custom_style: data_ref_manager.getDataRef("widget/wind/custom_style")
                data_ref_icon_enabled: data_ref_manager.getDataRef("widget/wind/icon_enabled")
                data_ref_icon_size: data_ref_manager.getDataRef("widget/wind/icon_size")
                data_ref_primary_color: data_ref_manager.getDataRef("widget/wind/primary_color")
                data_ref_secondary_color: data_ref_manager.getDataRef("widget/wind/secondary_color")
                data_ref_primary_font: data_ref_manager.getDataRef("widget/wind/primary_font")
                data_ref_secondary_font: data_ref_manager.getDataRef("widget/wind/secondary_font")

                BOSwitch {
                    id: dir_switch

                    label: "Show DIR"
                    description: "Enable DIR readout"
                    data_ref: data_ref_manager.getDataRef("widget/wind/dir_enabled")
                }

                BOSwitch {
                    label: "Prepend Zeros"
                    description: "Prepend zeros if DIR < 100°"
                    data_ref: data_ref_manager.getDataRef("widget/wind/prepend_zeros")
                    visible: dir_switch.checked
                }

                BOSwitch {
                    label: "Show MAG"
                    description: "Enable MAG readout"
                    data_ref: data_ref_manager.getDataRef("widget/wind/mag_enabled")
                }
            }

            BOWidgetSettings {
                label: "Temperature Settings"
                data_ref_custom_style: data_ref_manager.getDataRef("widget/temperature/custom_style")
                data_ref_icon_enabled: data_ref_manager.getDataRef("widget/temperature/icon_enabled")
                data_ref_icon_size: data_ref_manager.getDataRef("widget/temperature/icon_size")
                data_ref_primary_color: data_ref_manager.getDataRef("widget/temperature/primary_color")
                data_ref_secondary_color: data_ref_manager.getDataRef("widget/temperature/secondary_color")
                data_ref_primary_font: data_ref_manager.getDataRef("widget/temperature/primary_font")
                data_ref_secondary_font: data_ref_manager.getDataRef("widget/temperature/secondary_font")

                BOSwitch {
                    label: "Show OAT"
                    description: "Enable OAT readout"
                    data_ref: data_ref_manager.getDataRef("widget/temperature/oat_enabled")
                }

                BOSwitch {
                    label: "Show TAT"
                    description: "Enable TAT readout"
                    data_ref: data_ref_manager.getDataRef("widget/temperature/tat_enabled")
                }
            }

            BOWidgetSettings {
                label: "Performance Settings"
                data_ref_custom_style: data_ref_manager.getDataRef("widget/performance/custom_style")
                data_ref_icon_enabled: data_ref_manager.getDataRef("widget/performance/icon_enabled")
                data_ref_icon_size: data_ref_manager.getDataRef("widget/performance/icon_size")
                data_ref_primary_color: data_ref_manager.getDataRef("widget/performance/primary_color")
                data_ref_secondary_color: data_ref_manager.getDataRef("widget/performance/secondary_color")
                data_ref_primary_font: data_ref_manager.getDataRef("widget/performance/primary_font")
                data_ref_secondary_font: data_ref_manager.getDataRef("widget/performance/secondary_font")

                BOSwitch {
                    id: fps_switch

                    label: "Show FPS"
                    description: "Enable FPS readout"
                    data_ref: data_ref_manager.getDataRef("widget/performance/fps_enabled")
                }

                BOSpinBox {
                    label: "FPS Buffer Size"
                    data_ref: data_ref_manager.getDataRef("widget/performance/fps_buffer_size")
                    from: 1
                    visible: fps_switch.checked
                }

                BOSwitch {
                    label: "Show VAS"
                    description: "Enable VAS readout"
                    data_ref: data_ref_manager.getDataRef("widget/performance/vas_enabled")
                }
            }

            BOWidgetSettings {
                label: "Progress Settings"
                data_ref_custom_style: data_ref_manager.getDataRef("progress/custom_style")
                data_ref_icon_enabled: data_ref_manager.getDataRef("progress/icon_enabled")
                data_ref_icon_size: data_ref_manager.getDataRef("progress/icon_size")
                data_ref_primary_color: data_ref_manager.getDataRef("progress/primary_color")
                data_ref_secondary_color: data_ref_manager.getDataRef("progress/secondary_color")
                data_ref_primary_font: data_ref_manager.getDataRef("progress/primary_font")
                data_ref_secondary_font: data_ref_manager.getDataRef("progress/secondary_font")

                BOSwitch {
                    label: "Show DEP"
                    description: "Enable DEP readout"
                    data_ref: data_ref_manager.getDataRef("progress/dep_enabled")
                }

                BOSwitch {
                    label: "Show ARR"
                    description: "Enable ARR readout"
                    data_ref: data_ref_manager.getDataRef("progress/arr_enabled")
                }

                BOSwitch {
                    label: "Show DTG"
                    description: "Enable DTG readout"
                    data_ref: data_ref_manager.getDataRef("progress/dtg_enabled")
                }

                BOSwitch {
                    label: "Show ETA"
                    description: "Enable ETA readout"
                    data_ref: data_ref_manager.getDataRef("progress/eta_enabled")
                }

                BOSwitch {
                    label: "Show ETE"
                    description: "Enable ETE readout"
                    data_ref: data_ref_manager.getDataRef("progress/ete_enabled")
                }

                BOSwitch {
                    label: "Show Route"
                    description: "Enable Route readout"
                    data_ref: data_ref_manager.getDataRef("progress/route_enabled")
                }
            }

            BOGroupBox {
                label: "Landing Settings"

                ColumnLayout {
                    anchors {left: parent.left; top: parent.top; right: parent.right}
                    spacing: 16

                    BOSwitch {
                        id: settings_mode_switch

                        label: "Settings Mode"
                        description: "Set landing monitor to always visible"
                        data_ref: data_ref_manager.getDataRef("landing/settings_mode")
                    }

                    Button {
                        text: "Test Event"
                        visible: !settings_mode_switch.checked
                        onClicked: {
                            data_ref_manager.getDataRef("sim/on_ground").setData(false);
                            data_ref_manager.getDataRef("sim/on_ground").setData(true);
                        }
                    }

                    BOSpinBox {
                        label: "Popup Duration"
                        data_ref: data_ref_manager.getDataRef("landing/popup_duration")
                        from: 1
                    }

                    BOSwitch {
                        id: background_image_enabled_switch

                        label: "Background Image"
                        description: "Enable background image"
                        data_ref: data_ref_manager.getDataRef("landing/background_image_enabled")
                    }

                    BOImageSelector {
                        label: "Background Image"
                        data_ref: data_ref_manager.getDataRef("landing/background_image")
                        visible: background_image_enabled_switch.checked
                    }

                    BOSwitch {
                        label: "Title Enabled"
                        description: "Enable Title widget"
                        data_ref: data_ref_manager.getDataRef("landing/title/enabled")
                    }

                    BOSwitch {
                        label: "Network Rate"
                        description: "Enable Rate widget"
                        data_ref: data_ref_manager.getDataRef("landing/rate/enabled")
                    }

                    BOSwitch {
                        label: "Speed Enabled"
                        description: "Enable Speed widget"
                        data_ref: data_ref_manager.getDataRef("landing/speed/enabled")
                    }

                    BOSwitch {
                        label: "Attitude Enabled"
                        description: "Enable Attitude widget"
                        data_ref: data_ref_manager.getDataRef("landing/attitude/enabled")
                    }
                }
            }

            BOWidgetSettings {
                label: "Title Settings"
                data_ref_custom_style: data_ref_manager.getDataRef("landing/title/custom_style")
                data_ref_icon_enabled: data_ref_manager.getDataRef("landing/title/icon_enabled")
                data_ref_icon_size: data_ref_manager.getDataRef("landing/title/icon_size")
                data_ref_primary_color: data_ref_manager.getDataRef("landing/title/primary_color")
                data_ref_secondary_color: data_ref_manager.getDataRef("landing/title/secondary_color")
                data_ref_primary_font: data_ref_manager.getDataRef("landing/title/primary_font")
                data_ref_secondary_font: data_ref_manager.getDataRef("landing/title/secondary_font")
            }

            BOWidgetSettings {
                label: "Rate Settings"
                data_ref_custom_style: data_ref_manager.getDataRef("landing/rate/custom_style")
                data_ref_icon_enabled: data_ref_manager.getDataRef("landing/rate/icon_enabled")
                data_ref_icon_size: data_ref_manager.getDataRef("landing/rate/icon_size")
                data_ref_primary_color: data_ref_manager.getDataRef("landing/rate/primary_color")
                data_ref_secondary_color: data_ref_manager.getDataRef("landing/rate/secondary_color")
                data_ref_primary_font: data_ref_manager.getDataRef("landing/rate/primary_font")
                data_ref_secondary_font: data_ref_manager.getDataRef("landing/rate/secondary_font")

                BOSwitch {
                    label: "Show V/S"
                    description: "Enable V/S readout"
                    data_ref: data_ref_manager.getDataRef("landing/rate/vs_enabled")
                }

                BOSwitch {
                    label: "Show Pitch"
                    description: "Enable Pitch readout"
                    data_ref: data_ref_manager.getDataRef("landing/rate/pitch_enabled")
                }
            }

            BOWidgetSettings {
                label: "Speed Settings"
                data_ref_custom_style: data_ref_manager.getDataRef("landing/speed/custom_style")
                data_ref_icon_enabled: data_ref_manager.getDataRef("landing/speed/icon_enabled")
                data_ref_icon_size: data_ref_manager.getDataRef("landing/speed/icon_size")
                data_ref_primary_color: data_ref_manager.getDataRef("landing/speed/primary_color")
                data_ref_secondary_color: data_ref_manager.getDataRef("landing/speed/secondary_color")
                data_ref_primary_font: data_ref_manager.getDataRef("landing/speed/primary_font")
                data_ref_secondary_font: data_ref_manager.getDataRef("landing/speed/secondary_font")

                BOSwitch {
                    label: "Show IAS"
                    description: "Enable IAS readout"
                    data_ref: data_ref_manager.getDataRef("landing/speed/ias_enabled")
                }

                BOSwitch {
                    label: "Show GS"
                    description: "Enable GS readout"
                    data_ref: data_ref_manager.getDataRef("landing/speed/gs_enabled")
                }
            }

            BOWidgetSettings {
                label: "Attitude Settings"
                data_ref_custom_style: data_ref_manager.getDataRef("landing/attitude/custom_style")
                data_ref_icon_enabled: data_ref_manager.getDataRef("landing/attitude/icon_enabled")
                data_ref_icon_size: data_ref_manager.getDataRef("landing/attitude/icon_size")
                data_ref_primary_color: data_ref_manager.getDataRef("landing/attitude/primary_color")
                data_ref_secondary_color: data_ref_manager.getDataRef("landing/attitude/secondary_color")
                data_ref_primary_font: data_ref_manager.getDataRef("landing/attitude/primary_font")
                data_ref_secondary_font: data_ref_manager.getDataRef("landing/attitude/secondary_font")

                BOSwitch {
                    label: "Show Bank"
                    description: "Enable Bank readout"
                    data_ref: data_ref_manager.getDataRef("landing/attitude/bank_enabled")
                }
            }
        }

        Rectangle {
            id: notification_rectangle

            height: 50
            color: "#263238"
            visible: !data_ref_manager.getDataRef("sim/connected").data

            Layout.fillWidth: true

            Text {
                anchors.fill: parent

                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                color: "#edf0f2"
                font.pointSize: 10
                text: "Waiting for Flight Sim"
                wrapMode: Text.WordWrap
            }
        }
    }
}
