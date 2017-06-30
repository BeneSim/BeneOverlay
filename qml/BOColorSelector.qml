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
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.1
import Qt.labs.platform 1.0

BOItem {
    id: root

    Text {
        id: label_text

        text: root.label
        wrapMode: Text.WordWrap

        Layout.fillWidth: true
    }

    Item {

        implicitWidth: indicator_rectangle.implicitWidth
        implicitHeight: indicator_rectangle.implicitHeight

        Rectangle {
            id: indicator_rectangle

            anchors.centerIn: parent
            implicitWidth: 30
            implicitHeight: 30
            radius: 3
            border.color: Material.accent
            border.width: 2
            opacity: mouse_area.containsMouse

            MouseArea {
                id: mouse_area

                anchors.fill: parent
                hoverEnabled: true
                onClicked: value_color_dialog.open()
            }

            ColorDialog {
                id: value_color_dialog

                color: value_rectangle.color
                currentColor: value_rectangle.color
                onColorChanged: {
                    root.data_ref.data = value_color_dialog.color;
                }
            }
        }

        Rectangle {
            id: value_rectangle

            anchors {fill: indicator_rectangle; margins: 3}
            radius: 3
            color: root.data_ref.data
        }
    }
}
