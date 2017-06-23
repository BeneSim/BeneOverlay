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

BOItem {

    id: root

    anchors.leftMargin: 20
    anchors.topMargin: 20

    implicitWidth: 150

    property alias checked: checkbox.checked

    Switch {
        id: checkbox
        anchors.top: parent.top
        anchors.left: parent.left

        padding: 0

        checked: root.data_ref.data

        Binding {
            target: root.data_ref
            property: "data"
            value: checkbox.checked
        }

    }

    Item {
        anchors.verticalCenter: checkbox.verticalCenter
        anchors.left: checkbox.right
        anchors.leftMargin: 10

        implicitHeight: childrenRect.height
        implicitWidth: childrenRect.width

        Text {
            id: label

            anchors.top: parent.top
            anchors.left: parent.left

            text: root.name

            font.pointSize: 11

        }

        Text {
            anchors.top: label.bottom
            anchors.left: parent.left

            text: root.description

            color: Material.hintTextColor
        }

    }


}
