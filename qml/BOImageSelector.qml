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

BOItem {
    id: root

    implicitWidth: Math.max(label_text.implicitWidth, indicator_rectangle.implicitWidth + indicator_rectangle.anchors.leftMargin)
    implicitHeight: label_text.implicitHeight + indicator_rectangle.implicitHeight + indicator_rectangle.anchors.topMargin

    Text {
        id: label_text

        anchors {top: parent.top; left: parent.left; right: parent.right}
        text: root.label
        color: enabled? Material.foreground : Material.hintTextColor
    }

    Rectangle {
        id: indicator_rectangle

        anchors {left: parent.left; top: label_text.bottom; right: parent.right; bottom: parent.bottom; leftMargin: 10; topMargin: 8}

        implicitWidth: implicitHeight
        implicitHeight: 100
        radius: 3
        border {color: Material.accent; width: 2}
        visible: mouse_area.containsMouse
    }

    Image {
        id: value_image

        source: data_ref.data
        anchors {fill: indicator_rectangle; margins: 3}
        fillMode: Image.PreserveAspectCrop

        Binding {
            target: data_ref
            property: "data"
            value: value_image.source
        }
    }

    MouseArea {
        id: mouse_area

        anchors.fill: indicator_rectangle
        hoverEnabled: true
        onClicked: value_file_dialog.open()
    }

    FileDialog {
        id: value_file_dialog

        nameFilters: ["Image files (*.bmp *.png *.jpg *.jpeg *.gif *.svg)"]
        onFileChanged: {
            value_image.source = value_file_dialog.file
        }
    }
}
