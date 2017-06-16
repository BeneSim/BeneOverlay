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

RadioButton {

  id: root

  anchors.leftMargin: 10

  checked: false

  hoverEnabled: true

  property string label

  indicator: Rectangle {
    implicitWidth: 10

    anchors.right: parent.right
    anchors.top: parent.top
    anchors.bottom: parent.bottom

    //color: control.checked? "#7289da" : "#616367"
    color: root.checked? Material.accentColor : Material.background
    visible: root.hovered | root.checked ? true : false

  }

  contentItem: Text {
    text: root.label

    //color: control.hovered | control.checked? "#FFFFFF" : "#616367"
    color: root.hovered | root.checked? "#edf0f2" : "#61747e"
    font.pointSize: 10
    //horizontalAlignment: Text.AlignLeft
    //verticalAlignment: Text.AlignVCenter

  }

}
