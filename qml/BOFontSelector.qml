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

    Text {
        id: value_text

        text: root.data_ref.data.family + ", " + root.data_ref.data.pointSize
        font.family: root.data_ref.data.family
        font.pointSize: 11

        MouseArea {
            id: mouse_area

            anchors.fill: parent
            hoverEnabled: true
            onClicked: font_dialog.open()
        }

        FontDialog {
            id: font_dialog

            font: root.data_ref.data

            onFontChanged: {
                console.log("Font changed to " + font_dialog.font);
                root.data_ref.data = font_dialog.font;

            }
        }
    }

    Rectangle {
        id: indicator_rectangle

        implicitHeight: 2
        implicitWidth: value_text.implicitWidth
        color: Material.accentColor
        opacity: mouse_area.containsMouse
    }

}
