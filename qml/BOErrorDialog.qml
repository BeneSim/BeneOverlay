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

ApplicationWindow {
    id: root
    visible: true
    width: message_item.width + 20
    height: message_item.height + 20
    title: "BeneOverlay v" + VERSION_STRING

    Item {
        id: message_item

        width: childrenRect.width
        height: childrenRect.height

        anchors.centerIn: parent

        Text {
            id: title_text
            text: TITLE
            anchors.top: parent.top
            anchors.left: parent.left

            font.pointSize: 13
        }

        Text {
            id: message_text

            anchors.top: title_text.bottom
            anchors.left: parent.left
            anchors.topMargin: 10
            anchors.leftMargin: 10
            text: MESSAGE

            color: Material.hintTextColor
        }

    }

}
