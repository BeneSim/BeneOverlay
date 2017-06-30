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

function setupAltitude(data_refs) {
    setupCustomStyle(
        $("#altitude"),
        {
            "custom_style": data_refs["widget/altitude/custom_style"],
            "icon_enabled": data_refs["widget/altitude/icon_enabled"],
            "icon_size": data_refs["widget/altitude/icon_size"],
            "primary_color": data_refs["widget/altitude/primary_color"],
            "secondary_color": data_refs["widget/altitude/secondary_color"],
            "primary_font": data_refs["widget/altitude/primary_font"],
            "secondary_font": data_refs["widget/altitude/secondary_font"]
        },
        data_refs
    );

    attachToToggle($("#alt-row"), data_refs["widget/altitude/alt_enabled"]);
    attachToToggle($("#vs-row"), data_refs["widget/altitude/vs_enabled"]);

    attachToText($("#vs"), data_refs["sim/vs"]);

    function updateAirplane() {
        $("#airplane").attr("transform", "translate(0," + (-8 - (52 * getRatio(data_refs["sim/alt"].data, data_refs["flight/cruise_altitude"].data))) + ") rotate(" + (-data_refs["sim/pitch"].data) + ",40,89)");
    }

    attachToFun(updateAirplane, data_refs["flight/cruise_altitude"]);
    attachToFun(updateAirplane, data_refs["sim/pitch"]);
    attachToFun(updateAirplane, data_refs["sim/alt"]);

    function setAirplaneGear(val) {
        $("#airplane-gear").toggle(val);
    }
    attachToFun(setAirplaneGear, data_refs["sim/gear_down"]);

    function setAltitudeText() {
        if (data_refs["sim/alt"].data > data_refs["flight/transition_altitude"].data) {
            $("#alt").text("FL" + Math.round(data_refs["sim/alt"].data / 100));
            $("#alt_unit").text("");
        } else {
            $("#alt").text(data_refs["sim/alt"].data);
            $("#alt_unit").text("ft");
        }
    }

    attachToFun(setAltitudeText, data_refs["flight/transition_altitude"]);
    attachToFun(setAltitudeText, data_refs["sim/alt"]);
}
