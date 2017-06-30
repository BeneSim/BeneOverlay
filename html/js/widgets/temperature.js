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

function setupTemperature(data_refs) {
    setupCustomStyle(
        $("#temperature"),
        {
            "custom_style": data_refs["widget/temperature/custom_style"],
            "icon_enabled": data_refs["widget/temperature/icon_enabled"],
            "icon_size": data_refs["widget/temperature/icon_size"],
            "primary_color": data_refs["widget/temperature/primary_color"],
            "secondary_color": data_refs["widget/temperature/secondary_color"],
            "primary_font": data_refs["widget/temperature/primary_font"],
            "secondary_font": data_refs["widget/temperature/secondary_font"]
        },
        data_refs
    );

    attachToToggle($("#tat-row"), data_refs["widget/temperature/tat_enabled"]);
    attachToToggle($("#oat-row"), data_refs["widget/temperature/oat_enabled"]);

    attachToText($("#oat"), data_refs["sim/oat"]);
    attachToText($("#tat"), data_refs["sim/tat"]);

    function setTemperaturePointer(val) {
        $("#temperature-line").attr("y2", 15 + 47 * (1 - getRatio(val + 60, 100)));
    }

    attachToFun(setTemperaturePointer, data_refs["sim/oat"]);
}
