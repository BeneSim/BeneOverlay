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

function setupWind(data_refs) {
    setupCustomStyle(
        $("#wind"),
        {
            "custom_style": data_refs["widget/wind/custom_style"],
            "icon_enabled": data_refs["widget/wind/icon_enabled"],
            "icon_size": data_refs["widget/wind/icon_size"],
            "primary_color": data_refs["widget/wind/primary_color"],
            "secondary_color": data_refs["widget/wind/secondary_color"],
            "primary_font": data_refs["widget/wind/primary_font"],
            "secondary_font": data_refs["widget/wind/secondary_font"]
        },
        data_refs
    );

    attachToToggle($("#dir-row"), data_refs["widget/wind/dir_enabled"]);
    attachToToggle($("#mag-row"), data_refs["widget/wind/mag_enabled"]);

    attachToText($("#wind_mag"), data_refs["sim/wind_mag"]);

    $("#wind_dir").text(data_refs["widget/wind/prepend_zeros"].data ? prependZeros(data_refs["sim/wind_dir"].data, 3) : data_refs["sim/wind_dir"].data);
    data_refs["sim/wind_dir"].dataChanged.connect(function (new_value) {
      $("#wind_dir").text(data_refs["widget/wind/prepend_zeros"].data ? prependZeros(new_value, 3) : new_value);
    });
}
