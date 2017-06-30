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

function setupCallsign(data_refs) {
    setupCustomStyle(
        $("#callsign"),
        {
            "custom_style": data_refs["widget/callsign/custom_style"],
            "icon_enabled": data_refs["widget/callsign/icon_enabled"],
            "icon_size": data_refs["widget/callsign/icon_size"],
            "primary_color": data_refs["widget/callsign/primary_color"],
            "secondary_color": data_refs["widget/callsign/secondary_color"],
            "primary_font": data_refs["widget/callsign/primary_font"],
            "secondary_font": data_refs["widget/callsign/secondary_font"]
        },
        data_refs
    );

    attachToToggle($("#callsign-row"), data_refs["widget/callsign/callsign_enabled"]);
    attachToToggle($("#airline-row"), data_refs["widget/callsign/airline_enabled"]);

    attachToText($("#airline_icao"), data_refs["flight/airline_icao"]);
    attachToText($("#flight_number"), data_refs["flight/flight_number"]);
    attachToText($("#airline"), data_refs["flight/airline"]);
}
