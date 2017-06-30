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

function setupNetwork(data_refs) {
    setupCustomStyle(
        $("#network"),
        {
            "custom_style": data_refs["widget/network/custom_style"],
            "icon_enabled": data_refs["widget/network/icon_enabled"],
            "icon_size": data_refs["widget/network/icon_size"],
            "primary_color": data_refs["widget/network/primary_color"],
            "secondary_color": data_refs["widget/network/secondary_color"],
            "primary_font": data_refs["widget/network/primary_font"],
            "secondary_font": data_refs["widget/network/secondary_font"]
        },
        data_refs
    );

    attachToToggle($("#network-row"), data_refs["widget/network/network_enabled"]);
    attachToToggle($("#aircraft-row"), data_refs["widget/network/aircraft_enabled"]);

    attachToText($("#network_name"), data_refs["flight/network"]);
    attachToText($("#aircraft_icao"), data_refs["flight/aircraft_icao"]);

}
