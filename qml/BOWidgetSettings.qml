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

    property var data_ref_custom_style
    property var data_ref_icon_enabled
    property var data_ref_icon_size
    property var data_ref_primary_color
    property var data_ref_secondary_color
    property var data_ref_primary_font
    property var data_ref_secondary_font

    default property alias contents: content.data

        content.columnSpacing: 16
        content.rowSpacing: 16

        ColumnLayout {
            id: content

            spacing: 16

            Layout.columnSpan: 2
        }

        BOSwitch {
            id: custom_style_switch

            label: "Custom Style"
            description: "Enable custom styling for this widget"
            data_ref: root.data_ref_custom_style

            Layout.columnSpan: 2
        }

        BOSwitch {
            id: icon_enabled_switch

            label: "Icon Enabled"
            description: "Enable icon for this widget"
            data_ref: root.data_ref_icon_enabled
            visible: custom_style_switch.checked

            Layout.columnSpan: 2
        }

        BOSpinBox {
            label: "Icon Size"
            data_ref: root.data_ref_icon_size
            from: 0
            visible: custom_style_switch.checked && icon_enabled_switch.checked

            Layout.columnSpan: 2
        }

        BOColorSelector {
            label: "Primary Color"
            data_ref: data_ref_primary_color
            visible: custom_style_switch.checked

            Layout.fillWidth: false
        }

        BOColorSelector {
            label: "Secondary Color"
            data_ref: data_ref_secondary_color
            visible: custom_style_switch.checked

            Layout.fillWidth: true
        }

        BOFontSelector {
            label: "Primary Font"
            data_ref: root.data_ref_primary_font
            visible: custom_style_switch.checked

            Layout.fillWidth: false
        }

        BOFontSelector {
            label: "Secondary Font"
            data_ref: root.data_ref_secondary_font
            visible: custom_style_switch.checked

            Layout.fillWidth: true
        }
}
