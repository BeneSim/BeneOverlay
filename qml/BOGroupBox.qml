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
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.1

ColumnLayout {
    id: root

    property string label
    default property alias contents: content.data
    property alias content: content

    spacing: 0

    Text {
        id: label_text

        text: root.label
        font.pointSize: 12
        color: Material.hintTextColor

        Layout.fillWidth: true
        Layout.leftMargin: 20
        Layout.rightMargin: 20
        Layout.topMargin: 20
    }

    Flickable {
        id: content_flickable

        contentHeight: content.height
        clip: true

        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.leftMargin: 30
        Layout.topMargin: 20
        Layout.rightMargin: 20
        Layout.bottomMargin: 20

        ScrollBar.vertical: ScrollBar {
            id: vertical_scroll_bar

            policy: content_flickable.contentHeight > content_flickable.height? ScrollBar.AlwaysOn : ScrollBar.AlwaysOff
        }

        GridLayout {
            id: content

            columns: 2

            columnSpacing: 32
            rowSpacing: 32

            anchors {left: parent.left; top: parent.top; right: parent.right; rightMargin: 10}
        }
    }
}
