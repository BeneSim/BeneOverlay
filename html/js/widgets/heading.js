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

function setupHeading(data_refs) {
    setupCustomStyle(
        $("#heading"),
        {
            "custom_style": data_refs["widget/heading/custom_style"],
            "icon_enabled": data_refs["widget/heading/icon_enabled"],
            "icon_size": data_refs["widget/heading/icon_size"],
            "primary_color": data_refs["widget/heading/primary_color"],
            "secondary_color": data_refs["widget/heading/secondary_color"],
            "primary_font": data_refs["widget/heading/primary_font"],
            "secondary_font": data_refs["widget/heading/secondary_font"]
        },
        data_refs
    );

    attachToToggle($("#hdg-row"), data_refs["widget/heading/hdg_enabled"]);
    attachToToggle($("#trk-row"), data_refs["widget/heading/trk_enabled"]);

    $("#hdg").text(data_refs["widget/heading/prepend_zeros"].data ? prependZeros(data_refs["sim/hdg"].data, 3) : data_refs["sim/hdg"].data);
    data_refs["sim/hdg"].dataChanged.connect(function (new_value) {
      $("#hdg").text(data_refs["widget/heading/prepend_zeros"].data ? prependZeros(new_value, 3) : new_value);
    });

    $("#trk").text(data_refs["widget/heading/prepend_zeros"].data ? prependZeros(data_refs["sim/trk"].data, 3) : data_refs["sim/trk"].data);
    data_refs["sim/trk"].dataChanged.connect(function (new_value) {
      $("#trk").text(data_refs["widget/heading/prepend_zeros"].data ? prependZeros(new_value, 3) : new_value);
    });

    function setHdgPointer(val) {
        $("#hdg_pointer").attr("transform", "rotate(" + val + ",50,50)");
    }
    attachToFun(setHdgPointer, data_refs["sim/hdg"]);
}
