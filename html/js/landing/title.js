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

function setupTitle(data_refs) {
    setupCustomStyle(
        $("#title"),
        {
            "custom_style": data_refs["landing/title/custom_style"],
            "icon_enabled": data_refs["landing/title/icon_enabled"],
            "icon_size": data_refs["landing/title/icon_size"],
            "primary_color": data_refs["landing/title/primary_color"],
            "secondary_color": data_refs["landing/title/secondary_color"],
            "primary_font": data_refs["landing/title/primary_font"],
            "secondary_font": data_refs["landing/title/secondary_font"]
        },
        data_refs
    );
}
