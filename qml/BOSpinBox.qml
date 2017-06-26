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

BOItem {
    id: root

    property alias from: value_spin_box.from
    property alias to: value_spin_box.to

    implicitWidth: Math.max(label_text.implicitWidth, value_spin_box.implicitWidth + value_spin_box.anchors.leftMargin)
    implicitHeight: label_text.implicitHeight + value_spin_box.implicitHeight

    Text {
        id: label_text
        anchors {top: parent.top; left: parent.left; right: parent.right}
        text: root.label
    }

    SpinBox {
        id: value_spin_box

        anchors {top: label_text.bottom; left: parent.left; right: parent.right; bottom: parent.bottom; leftMargin: 10}
        value: data_ref.data
        editable: true

        Binding {
            target: data_ref
            property: "data"
            value: value_spin_box.value
        }
    }
}
