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
import QtQuick.Controls.Material 2.1
import Qt.labs.platform 1.0
//import QtQuick.Dialogs 1.2

BOItem {

  id: root

  anchors.leftMargin: 20
  anchors.topMargin: 20

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

    implicitWidth: 100
    implicitHeight: 100
    radius: 3

    border.color: Material.accent
    border.width: 2

    visible: mouse_area.containsMouse


  }

  Image {
    id: image_display

    source: data_ref.data

    anchors.centerIn: border_rect

    width: border_rect.width - 6
    height: border_rect.height - 6

    fillMode: Image.PreserveAspectCrop

    Binding {
      target: data_ref
      property: "data"
      value: image_display.source
    }
  }

  MouseArea {
    id: mouse_area
    anchors.fill: border_rect

    hoverEnabled: true

    onClicked: file_dialog.open()
  }

  FileDialog {
    id: file_dialog

    nameFilters: ["Image files (*.bmp *.png *.jpg *.jpeg *.gif *.svg)"]

    onFileChanged: {
      image_display.source = file_dialog.file
    }

  }


}
