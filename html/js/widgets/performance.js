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

function setupPerformance(data_refs) {
    setupCustomStyle(
        $("#performance"),
        {
            "custom_style": data_refs["widget/performance/custom_style"],
            "icon_enabled": data_refs["widget/performance/icon_enabled"],
            "icon_size": data_refs["widget/performance/icon_size"],
            "primary_color": data_refs["widget/performance/primary_color"],
            "secondary_color": data_refs["widget/performance/secondary_color"],
            "primary_font": data_refs["widget/performance/primary_font"],
            "secondary_font": data_refs["widget/performance/secondary_font"]
        },
        data_refs
    );

    attachToToggle($("#fps-row"), data_refs["widget/performance/fps_enabled"]);
    attachToToggle($("#vas-row"), data_refs["widget/performance/vas_enabled"]);

    attachToText($("#fps"), data_refs["sim/fps_mean"]);
    attachToText($("#vas"), data_refs["sim/vas"]);
}
