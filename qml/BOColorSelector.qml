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

BOItem {
    id: root

    implicitWidth: Math.max(label_text.implicitWidth, indicator_rectangle.implicitWidth + indicator_rectangle.anchors.leftMargin)
    implicitHeight: label_text.implicitHeight + indicator_rectangle.implicitHeight + indicator_rectangle.anchors.topMargin

    Text {
        id: label_text

        anchors {top: parent.top; left: parent.left; right: parent.right}
        text: root.label
    }

    Item {
        anchors {left: parent.left; top: label_text.bottom; right: parent.right; bottom: parent.bottom}

        Rectangle {
            id: indicator_rectangle

            anchors {left: parent.left; verticalCenter: parent.verticalCenter; leftMargin: 10; topMargin: 8}
            implicitWidth: 30
            implicitHeight: 30
            radius: 3
            border.color: Material.accent
            border.width: 2
            visible: mouse_area.containsMouse
        }

        Rectangle {
            id: value_rectangle

            anchors {fill: indicator_rectangle; margins: 3}
            radius: 3
            color: data_ref.data

            Binding {
                target: data_ref
                property: "data"
                value: value_rectangle.color
            }
        }

        MouseArea {
            id: mouse_area

            anchors.fill: indicator_rectangle
            hoverEnabled: true
            onClicked: color_dialog.open()
        }

        ColorDialog {
            id: color_dialog

            color: value_rectangle.color
            currentColor: value_rectangle.color
            onColorChanged: {
                value_rectangle.color = color_dialog.color;
            }
        }
    }
}
