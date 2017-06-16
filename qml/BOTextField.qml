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
import QtQuick.Layouts 1.1

BOItem {

  id: root

  property alias placeholderText: text_field.placeholderText
  property alias validator: text_field.validator

  anchors.leftMargin: 20
  anchors.topMargin: 20

  implicitWidth: 150

  Text {
    id: name_text
                anchors.top: parent.top
                anchors.left: parent.left
    text: root.name
  }

  TextField {

    id: text_field

    anchors.top: name_text.bottom
    anchors.left: parent.left
    anchors.leftMargin: 10
    anchors.right: parent.right

    text: data_ref.data

    onActiveFocusChanged: {
      if (activeFocus) {
        selectAll();
      }
    }

    Binding {
      target: data_ref
      property: "data"
      value: text_field.text
    }

  }



}
