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

function setupProgress(data_refs) {
    setupCustomStyle(
        $("#progress"),
        {
            "custom_style": data_refs["progress/custom_style"],
            "icon_enabled": data_refs["progress/icon_enabled"],
            "icon_size": data_refs["progress/icon_size"],
            "primary_color": data_refs["progress/primary_color"],
            "secondary_color": data_refs["progress/secondary_color"],
            "primary_font": data_refs["progress/primary_font"],
            "secondary_font": data_refs["progress/secondary_font"]
        },
        data_refs
    );

    attachToText($("#departure_icao"), data_refs["flight/departure_icao"]);
    attachToText($("#arrival_icao"), data_refs["flight/arrival_icao"]);
    attachToText($("#route"), data_refs["flight/route"]);
    attachToText($("#distance_to_destination"), data_refs["flight/distance_to_destination"]);
    attachToText($("#eta"), data_refs["flight/eta"]);
    attachToText($("#ete"), data_refs["flight/ete"]);

    attachToToggle($("#dep-row"), data_refs["progress/dep_enabled"]);
    attachToToggle($("#arr-row"), data_refs["progress/arr_enabled"]);
    attachToToggle($("#dtg-row"), data_refs["progress/dtg_enabled"]);
    attachToToggle($("#eta-row"), data_refs["progress/eta_enabled"]);
    attachToToggle($("#ete-row"), data_refs["progress/ete_enabled"]);
    attachToToggle($("#route"), data_refs["progress/route_enabled"]);

    function setProgressBarViewBox() {
        let width = $("#progress_bar").width();
        let height = $("#progress_bar").height();
        $("#progress_bar").attr("viewBox", "0 0 " + width * 100 / height + " 100");
    }
    $(window).resize(setProgressBarViewBox);

    attachToFun(setProgressBarViewBox, data_refs["progress/custom_style"]);
    attachToFun(setProgressBarViewBox, data_refs["progress/icon_size"]);
    attachToFun(setProgressBarViewBox, data_refs["progress/primary_font"]);
    attachToFun(setProgressBarViewBox, data_refs["progress/secondary_font"]);
    attachToFun(setProgressBarViewBox, data_refs["global/icon_size"]);
    attachToFun(setProgressBarViewBox, data_refs["global/primary_font"]);
    attachToFun(setProgressBarViewBox, data_refs["global/secondary_font"]);

    attachToFun(setProgressBarViewBox, data_refs["flight/departure_icao"]);
    attachToFun(setProgressBarViewBox, data_refs["flight/arrival_icao"]);
    attachToFun(setProgressBarViewBox, data_refs["flight/distance_to_destination"]);
    attachToFun(setProgressBarViewBox, data_refs["flight/eta"]);

    function setProgressBarValue() {
        let ratio = getRatio(data_refs["flight/distance_to_destination"].data, data_refs["flight/route_distance"].data);
        $("#progress-line").attr("x2", "calc((100% - 20) * " + (1 - ratio) + " + 10)");
    }

    attachToFun(setProgressBarValue, data_refs["flight/distance_to_destination"]);
    attachToFun(setProgressBarValue, data_refs["flight/route_distance"]);

    setProgressBarViewBox();
}
