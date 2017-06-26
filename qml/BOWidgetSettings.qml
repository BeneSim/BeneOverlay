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
import QtQuick.Layouts 1.3

BOGroupBox {
    id: root

    property var data_ref_enabled
    property var data_ref_custom_style
    property var data_ref_icon_enabled
    property var data_ref_icon_size
    property var data_ref_primary_color
    property var data_ref_secondary_color
    property var data_ref_primary_font
    property var data_ref_secondary_font

    default property alias contents: content.data

    GridLayout {
        anchors {left: parent.left; top: parent.top; right: parent.right}
        columns: 2
        columnSpacing: 16
        rowSpacing: 16

        BOSwitch {
            id: enabled_switch

            label: "Enabled"
            description: "Enable this widget"
            data_ref: root.data_ref_enabled
            Layout.columnSpan: 2
        }

        ColumnLayout {
            id: content

            spacing: 16
            visible: enabled_switch.checked
        }

        BOSwitch {
            id: custom_style_switch

            label: "Custom Style"
            description: "Enable custom styling for this widget"
            data_ref: root.data_ref_custom_style
            Layout.columnSpan: 2
            visible: enabled_switch.checked

            onHeightChanged: {
                console.log(height);
            }
        }

        BOSpinBox {
            label: "Icon Size"
            data_ref: root.data_ref_icon_size
            from: 0
            Layout.columnSpan: 2
            visible: custom_style_switch.checked && custom_style_switch.visible
        }

        BOColorSelector {
            label: "Primary Color"
            data_ref: data_ref_primary_color
            visible: custom_style_switch.checked && custom_style_switch.visible
        }

        BOColorSelector {
            label: "Secondary Color"
            data_ref: data_ref_secondary_color
            visible: custom_style_switch.checked && custom_style_switch.visible
        }

        BOFontSelector {
            label: "Primary Font"
            data_ref: root.data_ref_primary_font
            visible: custom_style_switch.checked && custom_style_switch.visible
        }

        BOFontSelector {
            label: "Secondary Font"
            data_ref: root.data_ref_secondary_font
            visible: custom_style_switch.checked && custom_style_switch.visible
        }
    }
}
