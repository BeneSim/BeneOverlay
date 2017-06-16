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

  implicitWidth: childrenRect.width > 150 ? childrenRect.width : 150

  Text {
    id: name_text
    anchors.top: parent.top
    anchors.left: parent.left
    text: root.name
  }

  Text {
    id: font_text

    anchors.top: name_text.bottom
    anchors.left: parent.left
    anchors.leftMargin: 10
    anchors.topMargin: 8

    text: data_ref.data.family + ", " + data_ref.data.pointSize

    font.family: data_ref.data.family
    font.pointSize: 11
  }

  Rectangle {
    anchors.left: font_text.left
    anchors.right: font_text.right
    anchors.top: font_text.bottom

    height: 2

    color: Material.accentColor

    visible: mouse_area.containsMouse
  }

  MouseArea {
    id: mouse_area

    anchors.fill: font_text

    hoverEnabled: true

    onClicked: font_dialog.open()
  }

  FontDialog {
    id: font_dialog

    font: data_ref.data

    onFontChanged: {
      console.log("Font changed to " + font_dialog.font);
      data_ref.data = font_dialog.font;

    }
  }




}
