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
import QtQuick.Controls.Material 2.1

Item {
    id: root

    property string label
    default property alias contents: content.data

    implicitWidth: Math.max(label_text.implicitWidth, content.implicitWidth)
    implicitHeight: label_text.implicitHeight + content.implicitHeight

    Text {
        id: label_text

        anchors {left: parent.left; top: parent.top; right: parent.right}
        text: root.label
        font.pointSize: 12
        color: Material.hintTextColor
    }

    Flickable {
        id: content_flickable

        anchors {left: parent.left; top: label_text.bottom; right: parent.right; bottom: parent.bottom}
        contentHeight: content.height + content.anchors.topMargin
        clip: true
        ScrollBar.vertical: ScrollBar {
            id: vertical_scroll_bar

            policy: content_flickable.contentHeight > content_flickable.height? ScrollBar.AlwaysOn : ScrollBar.AlwaysOff
        }

        Item {
            id: content

            implicitWidth: children[0].implicitWidth
            implicitHeight: children[0].implicitHeight

            anchors {left: parent.left; top: parent.top; right: parent.right; leftMargin: 8; topMargin: 16; rightMargin: vertical_scroll_bar.visible? vertical_scroll_bar.width + 8 : 8}
        }
    }
}
