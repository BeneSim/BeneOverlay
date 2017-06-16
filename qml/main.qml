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
  height: 750
  title: "BeneOverlay v" + VERSION_STRING

  Dialog {

    property alias text: dialog_message.text
    property string download_url

    id: dialog

    width: 400
    height: 400

    standardButtons: Dialog.Open

    modal: true

    Flickable {
      id: dialog_flickable
      anchors.fill: parent

      contentHeight: dialog_message.height

      clip: true

      ScrollBar.vertical: ScrollBar {
        id: scroll_bar
        policy: dialog_flickable.contentHeight > dialog_flickable.height? ScrollBar.AlwaysOn : ScrollBar.AsNeeded
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


    x: (parent.width - dialog.width)/2
    y: (parent.height - dialog.height)/2

    onAccepted: Qt.openUrlExternally(download_url)

  }

  UpdateManager {

    id: update_manager

    user: "benesim"
    repo: "beneoverlay"

    Component.onCompleted: update_manager.checkForUpdate()

    onUpdateAvailable: {
      dialog.title = "Version " + version_string + " available!";
      dialog.text = "<style>a { color: " + Material.accent + "; }</style>" + new Showdown.showdown.Converter().makeHtml(body);
      dialog.download_url = download_url;
      console.log(dialog.text);
      dialog.open();
    }

  }

  Rectangle {
    id: menu

    property int index: 0

    anchors.top: parent.top
    anchors.bottom: parent.bottom
    anchors.left: parent.left

    width: 180

    color: "#263238"

    Image {
      id: logo_image
      anchors.top: parent.top
      anchors.left: parent.left
      anchors.leftMargin: 10
      anchors.topMargin: 10
      source: "qrc:/images/beneoverlay.png"
    }

    BOMenuItem {
      id: flight_menu_item

      anchors.top: logo_image.bottom
      anchors.topMargin: 20
      anchors.left: parent.left
      anchors.right: parent.right

      label: "Flight"

      checked: true

      onCheckedChanged: if (checked) menu.index = 0
    }

    BOMenuItem {
      id: general_menu_item

      anchors.top: flight_menu_item.bottom
      anchors.left: parent.left
      anchors.right: parent.right

      label: "General"

      onCheckedChanged: if (checked) menu.index = 1
    }

    Text {
      id: widgets_text
      text: "Widgets"

      height: general_menu_item.height
      verticalAlignment: Text.AlignVCenter

      anchors.top: general_menu_item.bottom
      anchors.left: parent.left
      anchors.leftMargin: 18

      color: "#61747e"
      font.pointSize: 10
    }

    BOMenuItem {
      id: callsign_menu_item

      anchors.top: widgets_text.bottom
      anchors.left: parent.left
      anchors.leftMargin: 20
      anchors.right: parent.right

      label: "Callsign"

      onCheckedChanged: if (checked) menu.index = 2
    }

    BOMenuItem {
      id: network_menu_item

      anchors.top: callsign_menu_item.bottom
      anchors.left: parent.left
      anchors.leftMargin: 20
      anchors.right: parent.right

      label: "Network"

      onCheckedChanged: if (checked) menu.index = 3
    }

    BOMenuItem {
      id: speed_menu_item

      anchors.top: network_menu_item.bottom
      anchors.left: parent.left
      anchors.leftMargin: 20
      anchors.right: parent.right

      label: "Speed"

      onCheckedChanged: if (checked) menu.index = 4
    }

    BOMenuItem {
      id: heading_menu_item

      anchors.top: speed_menu_item.bottom
      anchors.left: parent.left
      anchors.leftMargin: 20
      anchors.right: parent.right

      label: "Heading"

      onCheckedChanged: if (checked) menu.index = 5
    }

    BOMenuItem {
      id: altitude_menu_item

      anchors.top: heading_menu_item.bottom
      anchors.left: parent.left
      anchors.leftMargin: 20
      anchors.right: parent.right

      label: "Altitude"

      onCheckedChanged: if (checked) menu.index = 6
    }

    BOMenuItem {
      id: wind_menu_item

      anchors.top: altitude_menu_item.bottom
      anchors.left: parent.left
      anchors.leftMargin: 20
      anchors.right: parent.right

      label: "Wind"

      onCheckedChanged: if (checked) menu.index = 7
    }

    BOMenuItem {
      id: temperature_menu_item

      anchors.top: wind_menu_item.bottom
      anchors.left: parent.left
      anchors.leftMargin: 20
      anchors.right: parent.right

      label: "Temperature"

      onCheckedChanged: if (checked) menu.index = 8
    }

    BOMenuItem {
      id: performance_menu_item

      anchors.top: temperature_menu_item.bottom
      anchors.left: parent.left
      anchors.leftMargin: 20
      anchors.right: parent.right

      label: "Performance"

      onCheckedChanged: if (checked) menu.index = 9
    }

    BOMenuItem {
      id: progress_menu_item

      anchors.top: performance_menu_item.bottom
      anchors.left: parent.left
      anchors.right: parent.right

      label: "Progress"

      onCheckedChanged: if (checked) menu.index = 10
    }

    BOMenuItem {
      id: landing_monitor_menu_item

      anchors.top: progress_menu_item.bottom
      anchors.left: parent.left
      anchors.right: parent.right

      label: "Landing"

      onCheckedChanged: if (checked) menu.index = 11
    }
  }

  StackLayout {

    anchors.left: menu.right
    anchors.top: parent.top
    anchors.bottom: parent.bottom
    anchors.right: parent.right

    currentIndex: menu.index

    BOGroupBox {
      name: "Flight Settings"

      anchors.fill: parent

      BOTextField {
        id: departure_icao_text_field

        anchors.left: parent.left
        anchors.top: parent.top

        name: "Departure ICAO"
        placeholderText: "EDDT"
        data_ref: data_ref_manager.getDataRef("flight/departure_icao")
      }

      BOTextField {
        id: arrival_icao_text_field

        anchors.left: departure_icao_text_field.right
        anchors.verticalCenter: departure_icao_text_field.verticalCenter

        name: "Arrival ICAO"
        placeholderText: "LSZH"
        data_ref: data_ref_manager.getDataRef("flight/arrival_icao")
      }

      BOTextField {
        id: route_text_field

        anchors.top: departure_icao_text_field.bottom
        anchors.left: parent.left

        width: 320

        name: "Route"
        placeholderText: "BRANE Q201 BUREL UM736 TABAT UL87 ANELA UN869 TEDGO T724 RILAX"
        data_ref: data_ref_manager.getDataRef("flight/route")
      }


      BOTextField {
        id: airline_text_field

        anchors.top: route_text_field.bottom
        anchors.left: parent.left

        name: "Airline"
        placeholderText: "Global Wings"
        data_ref: data_ref_manager.getDataRef("flight/airline")
      }

      BOTextField {
        id: airline_icao_text_field

        anchors.left: airline_text_field.right
        anchors.verticalCenter: airline_text_field.verticalCenter

        name: "Airline ICAO"
        placeholderText: "GLW"
        data_ref: data_ref_manager.getDataRef("flight/airline_icao")
      }

      BOTextField {
        id: flight_number_text_field

        anchors.top: airline_text_field.bottom
        anchors.left: parent.left

        name: "Flight Number"
        placeholderText: "568A"
        data_ref: data_ref_manager.getDataRef("flight/flight_number")
      }

      BOTextField {
        id: network_text_field

        anchors.left: flight_number_text_field.right
        anchors.verticalCenter: flight_number_text_field.verticalCenter

        name: "Network"
        placeholderText: "IVAO"
        data_ref: data_ref_manager.getDataRef("flight/network")
      }

      BOTextField {
        id: flight_altitude_text_field

        anchors.top: flight_number_text_field.bottom
        anchors.left: parent.left

        name: "Cruise Altitude"
        placeholderText: "12000"
        data_ref: data_ref_manager.getDataRef("flight/cruise_altitude")

        validator: IntValidator {
          bottom: 0
        }
      }

      BOTextField {
        id: max_ias_text_field

        anchors.left: flight_altitude_text_field.right
        anchors.verticalCenter: flight_altitude_text_field.verticalCenter

        name: "Max IAS"
        placeholderText: "300"
        data_ref: data_ref_manager.getDataRef("flight/max_ias")

        validator: IntValidator {
          bottom: 0
        }
      }

      BOTextField {
        id: transition_altitude_text_field

        anchors.top: flight_altitude_text_field.bottom
        anchors.left: parent.left

        name: "Transition Altitude"
        placeholderText: "5000"
        data_ref: data_ref_manager.getDataRef("flight/transition_altitude")

        validator: IntValidator {
          bottom: 0
        }
      }

      BOTextField {
        id: aircraft_icao_text_field

        anchors.left: transition_altitude_text_field.right
        anchors.verticalCenter: transition_altitude_text_field.verticalCenter

        name: "Aircraft ICAO"
        placeholderText: "B738"
        data_ref: data_ref_manager.getDataRef("flight/aircraft_icao")
      }
    }

    BOGroupBox {
      anchors.fill: parent
      name: "General Settings"

      BOSpinBox {
        id: data_rate_spin_box

        anchors.top: parent.top
        anchors.left: parent.left

        name: "Data Rate"
        from: 1
        to: 60
        data_ref: data_ref_manager.getDataRef("global/data_rate")
      }

      BOSwitch {
        id: icon_enabled_switch

        anchors.top: data_rate_spin_box.bottom
        anchors.left: parent.left

        name: "Icons Enabled"
        description: "Enable icons for the widgets"
        data_ref: data_ref_manager.getDataRef("global/icon_enabled")
      }

      BOSpinBox {
        id: icon_size_spin_box

        anchors.top: icon_enabled_switch.bottom
        anchors.left: parent.left

        name: "Icon Size"
        data_ref: data_ref_manager.getDataRef("global/icon_size")
        from: 0

        visible: icon_enabled_switch.checked
      }

      BOColorSelector {

        id: primary_color_color_selector

        anchors.top: icon_size_spin_box.visible? icon_size_spin_box.bottom : icon_enabled_switch.bottom
        anchors.left: parent.left

        name: "Primary Color"
        data_ref: data_ref_manager.getDataRef("global/primary_color")

      }

      BOColorSelector {

        id: secondary_color_color_selector

        anchors.left: primary_color_color_selector.right
        anchors.verticalCenter: primary_color_color_selector.verticalCenter

        name: "Secondary Color"
        data_ref: data_ref_manager.getDataRef("global/secondary_color")

      }

      BOFontSelector {

        id: primary_font_font_selector

        anchors.top: secondary_color_color_selector.bottom
        anchors.left: parent.left

        name: "Primary Font"

        data_ref: data_ref_manager.getDataRef("global/primary_font")
      }

      BOFontSelector {
        id: secondary_font_font_selector

        anchors.left: primary_font_font_selector.right
        anchors.top: secondary_color_color_selector.bottom

        name: "Secondary Font"

        data_ref: data_ref_manager.getDataRef("global/secondary_font")
      }
    }

    BOWidget {
      anchors.fill: parent

      name: "Callsign Settings"

      data_ref_enabled: data_ref_manager.getDataRef("widget/callsign/enabled")
      data_ref_custom_style: data_ref_manager.getDataRef("widget/callsign/custom_style")
      data_ref_icon_enabled: data_ref_manager.getDataRef("widget/callsign/icon_enabled")
      data_ref_icon_size: data_ref_manager.getDataRef("widget/callsign/icon_size")
      data_ref_primary_color: data_ref_manager.getDataRef("widget/callsign/primary_color")
      data_ref_secondary_color: data_ref_manager.getDataRef("widget/callsign/secondary_color")
      data_ref_primary_font: data_ref_manager.getDataRef("widget/callsign/primary_font")
      data_ref_secondary_font: data_ref_manager.getDataRef("widget/callsign/secondary_font")
    }

    BOWidget {
      anchors.fill: parent

      name: "Network Settings"

      data_ref_enabled: data_ref_manager.getDataRef("widget/network/enabled")
      data_ref_custom_style: data_ref_manager.getDataRef("widget/network/custom_style")
      data_ref_icon_enabled: data_ref_manager.getDataRef("widget/network/icon_enabled")
      data_ref_icon_size: data_ref_manager.getDataRef("widget/network/icon_size")
      data_ref_primary_color: data_ref_manager.getDataRef("widget/network/primary_color")
      data_ref_secondary_color: data_ref_manager.getDataRef("widget/network/secondary_color")
      data_ref_primary_font: data_ref_manager.getDataRef("widget/network/primary_font")
      data_ref_secondary_font: data_ref_manager.getDataRef("widget/network/secondary_font")
    }

    BOWidget {
      anchors.fill: parent

      name: "Speed Settings"

      data_ref_enabled: data_ref_manager.getDataRef("widget/speed/enabled")
      data_ref_custom_style: data_ref_manager.getDataRef("widget/speed/custom_style")
      data_ref_icon_enabled: data_ref_manager.getDataRef("widget/speed/icon_enabled")
      data_ref_icon_size: data_ref_manager.getDataRef("widget/speed/icon_size")
      data_ref_primary_color: data_ref_manager.getDataRef("widget/speed/primary_color")
      data_ref_secondary_color: data_ref_manager.getDataRef("widget/speed/secondary_color")
      data_ref_primary_font: data_ref_manager.getDataRef("widget/speed/primary_font")
      data_ref_secondary_font: data_ref_manager.getDataRef("widget/speed/secondary_font")
    }

    BOWidgetHeading {
      anchors.fill: parent
    }

    BOWidget {
      anchors.fill: parent

      name: "Altitude Settings"

      data_ref_enabled: data_ref_manager.getDataRef("widget/altitude/enabled")
      data_ref_custom_style: data_ref_manager.getDataRef("widget/altitude/custom_style")
      data_ref_icon_enabled: data_ref_manager.getDataRef("widget/altitude/icon_enabled")
      data_ref_icon_size: data_ref_manager.getDataRef("widget/altitude/icon_size")
      data_ref_primary_color: data_ref_manager.getDataRef("widget/altitude/primary_color")
      data_ref_secondary_color: data_ref_manager.getDataRef("widget/altitude/secondary_color")
      data_ref_primary_font: data_ref_manager.getDataRef("widget/altitude/primary_font")
      data_ref_secondary_font: data_ref_manager.getDataRef("widget/altitude/secondary_font")
    }

    BOWidgetWind {
      anchors.fill: parent

    }

    BOWidgetTemperature {
      anchors.fill: parent

    }

    BOWidgetPerformance {
      anchors.fill: parent

    }

    BOProgress {

      anchors.fill: parent
      name: "Progress Settings"
      data_ref_custom_style: data_ref_manager.getDataRef("progress/custom_style")
      data_ref_icon_enabled: data_ref_manager.getDataRef("progress/icon_enabled")
      data_ref_icon_size: data_ref_manager.getDataRef("progress/icon_size")
      data_ref_primary_color: data_ref_manager.getDataRef("progress/primary_color")
      data_ref_secondary_color: data_ref_manager.getDataRef("progress/secondary_color")
      data_ref_primary_font: data_ref_manager.getDataRef("progress/primary_font")
      data_ref_secondary_font: data_ref_manager.getDataRef("progress/secondary_font")

    }

    BOLanding {

      anchors.fill: parent
    }

  }

  Rectangle {
    anchors.left: menu.right
    anchors.bottom: parent.bottom
    anchors.right: parent.right

    height: 50

    color: "#263238"

    Text {
      id: notification_text
      anchors.centerIn: parent

      color: "#edf0f2"
      font.pointSize: 10

      text: "Waiting for Flight Sim"

    }

    //BusyIndicator {
    //  anchors.left: notification_text.right
    //  anchors.verticalCenter: notification_text.verticalCenter

    //  height: 30
    //  width: 30
    //}

    visible: !data_ref_manager.getDataRef("sim/connected").data

  }


}
