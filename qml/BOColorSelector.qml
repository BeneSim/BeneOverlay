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

import QtQuick 2.0
import QtQuick.Controls 2.1
import QtQuick.Controls.Material 2.1
import Qt.labs.platform 1.0
//import QtQuick.Dialogs 1.2

BOItem {

  id: root

  anchors.leftMargin: 20
  anchors.topMargin: 20

  implicitWidth: 150

  Text {
    id: name_text
    anchors.top: parent.top
    anchors.left: parent.left
    text: root.name

    color: enabled? Material.foreground : Material.hintTextColor
  }

  Rectangle {

    id: border_rect

    anchors.top: name_text.bottom
    anchors.left: parent.left
    anchors.leftMargin: 10
    anchors.topMargin: 8

    implicitWidth: 30
    implicitHeight: 30
    radius: 3

    border.color: Material.accent
    border.width: 2

    visible: mouse_area.containsMouse


  }

  Rectangle {

    id: color_rect

    anchors.centerIn: border_rect

    implicitHeight: 24
    implicitWidth: 24
    radius: 3

    color: data_ref.data

    Binding {
      target: data_ref
      property: "data"
      value: color_rect.color
    }

  }

  MouseArea {
    id: mouse_area
    anchors.fill: border_rect

    hoverEnabled: true
    //cursorShape: Qt.PointingHandCursor

    onClicked: color_dialog.open()
  }

  ColorDialog {
    id: color_dialog

    color: color_rect.color
    currentColor: color_rect.color

    onColorChanged: {
      color_rect.color = color_dialog.color;
    }
  }


}
