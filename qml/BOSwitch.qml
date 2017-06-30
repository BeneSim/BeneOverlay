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

BOItem {
    id: root

    property alias checked: value_checkbox.checked

    Switch {
        id: value_checkbox

        padding: 0
        checked: root.data_ref.data

        Layout.rowSpan: 2
        Layout.column: 0
        Layout.row: 0

        Binding {
            target: root.data_ref
            property: "data"
            value: value_checkbox.checked
        }
    }

    Text {
        id: label_text

        text: root.label
        font.pointSize: 11
        wrapMode: Text.WordWrap

        Layout.row: 0
        Layout.column: 1
        Layout.fillWidth: true
    }

    Text {
        id: description_text

        text: root.description
        color: Material.hintTextColor
        wrapMode: Text.WordWrap

        Layout.row: 1
        Layout.column: 1
        Layout.fillWidth: true
    }
}
