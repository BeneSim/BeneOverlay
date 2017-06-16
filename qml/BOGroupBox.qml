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

Item {

  id: root

  property string name
  default property alias contents: content.children

  anchors.leftMargin: 30
  anchors.topMargin: 30

  Text {
    id: name_text

    anchors.left: parent.left
    anchors.top: parent.top

    text: root.name
    font.pointSize: 12
    color: Material.hintTextColor
  }

  Item {
    id: content

    anchors.left: parent.left
    anchors.top: name_text.bottom
    anchors.bottom: parent.bottom
    anchors.right: parent.right

  }


}
