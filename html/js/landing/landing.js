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

function setupLanding(data_refs) {
    setupTitle(data_refs);
    setupRate(data_refs);
    setupSpeed(data_refs);
    setupAttitude(data_refs);

    attachToToggle($("#title"), data_refs["landing/title/enabled"]);
    attachToToggle($("#rate"), data_refs["landing/rate/enabled"]);
    attachToToggle($("#speed"), data_refs["landing/speed/enabled"]);
    attachToToggle($("#attitude"), data_refs["landing/attitude/enabled"]);


    function updateBackgroundImage() {
        if (data_refs["landing/background_image_enabled"].data) {
            $("#background").attr("src", data_refs["landing/background_image"].data);
        } else {
            $("#background").attr("src", "");
        }
    }

    attachToFun(updateBackgroundImage, data_refs["landing/background_image"]);
    attachToFun(updateBackgroundImage, data_refs["landing/background_image_enabled"]);

    function setVisible(val) {
        if (val) {
            $("#landing").fadeIn("fast");
            $("#background").fadeIn("fast");
        } else {
            $("#landing").fadeOut("slow");
            $("#background").fadeOut("slow");
        }
    }

    attachToFun(setVisible, data_refs["landing/settings_mode"]);

    data_refs["sim/on_ground"].dataChanged.connect(function (new_value) {
        if (new_value && !$("#landing").is(":visible")) {
            $("#vs").text(data_refs["sim/vs_air"].data);
            $("#pitch").text(data_refs["sim/pitch"].data);
            $("#ias").text(data_refs["sim/ias"].data);
            $("#gs").text(data_refs["sim/gs"].data);

            let bank = data_refs["sim/bank"].data;
            $("#bank").text(Math.abs(bank));

            if (bank > 0) {
                $("#bank-dir").text("Left");
            } else if (bank < 0) {
                $("#bank-dir").text("Right");
            } else {
                $("#bank-dir").text("");
            }

            setVisible(true);

            if (!data_refs["landing/settings_mode"].data) {
                setTimeout(function () {
                    setVisible(data_refs["landing/settings_mode"].data);
                }, data_refs["landing/popup_duration"].data * 1000);
            }

        }
    });
}
