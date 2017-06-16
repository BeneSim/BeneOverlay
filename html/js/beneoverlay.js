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

function getRatio(value, reference) {
    if (reference == 0) {
        return 0;
    }
    let val = value / reference;

    if (val > 1) {
        return 1;
    }
    if (val < 0) {
        return 0;
    }
    return val;
}

function setConditional(element, fun, custom_style, val, global_val) {
    fun(element, custom_style ? val : global_val);
}

function setIconEnabled(element, val) {
    element.find(".icon").toggle(val);
}

function setIconSize(element, val) {
    element.find(".icon").css("height", val);
}

function setPrimaryColor(element, val) {
    element.find(".primary-color").css("color", val);
    element.find(".primary-fill").css("fill", val);
    element.find(".primary-stroke").css("stroke", val);
}

function setSecondaryColor(element, val) {
    element.find(".secondary-color").css("color", val);
    element.find(".secondary-fill").css("fill", val);
    element.find(".secondary-stroke").css("stroke", val);
}

function setPrimaryFont(element, val) {
    let font_data = val.split(",");
    element.find(".primary-font").css({"font-family": font_data[0], "font-size": font_data[1] + "pt"});
}

function setSecondaryFont(element, val) {
    let font_data = val.split(",");
    element.find(".secondary-font").css({"font-family": font_data[0], "font-size": font_data[1] + "pt"});
}

function attachToText(element, data_ref) {
    element.text(data_ref.data);
    data_ref.dataChanged.connect(function (new_value) {
        element.text(new_value);
    });
}

function attachToFun(fun, data_ref) {
    fun(data_ref.data);
    data_ref.dataChanged.connect(function (new_value) {
        fun(new_value);
    });
}

function attachToAttr(element, attr, data_ref) {
    element.attr(attr, data_ref.data);
    data_ref.dataChanged.connect(function (new_value) {
        element.attr(attr, new_value);
    });
}

function attachToToggle(element, data_ref) {
    element.toggle(data_ref.data);
    data_ref.dataChanged.connect(function (new_value) {
        element.toggle(new_value);
    });
}

function setupCustomStyle(element, custom_style_data_refs, data_refs) {

    setConditional(
        element,
        setIconEnabled,
        custom_style_data_refs.custom_style.data,
        custom_style_data_refs.icon_enabled.data,
        data_refs["global/icon_enabled"].data
    );
    setConditional(
        element,
        setIconSize,
        custom_style_data_refs.custom_style.data,
        custom_style_data_refs.icon_size.data,
        data_refs["global/icon_size"].data
    );
    setConditional(
        element,
        setPrimaryColor,
        custom_style_data_refs.custom_style.data,
        custom_style_data_refs.primary_color.data,
        data_refs["global/primary_color"].data
    );
    setConditional(
        element,
        setSecondaryColor,
        custom_style_data_refs.custom_style.data,
        custom_style_data_refs.secondary_color.data,
        data_refs["global/secondary_color"].data
    );
    setConditional(
        element,
        setPrimaryFont,
        custom_style_data_refs.custom_style.data,
        custom_style_data_refs.primary_font.data,
        data_refs["global/primary_font"].data
    );
    setConditional(
        element,
        setSecondaryFont,
        custom_style_data_refs.custom_style.data,
        custom_style_data_refs.secondary_font.data,
        data_refs["global/secondary_font"].data
    );

    custom_style_data_refs.custom_style.dataChanged.connect(function (new_value) {
        setConditional(
            element,
            setIconEnabled,
            new_value,
            custom_style_data_refs.icon_enabled.data,
            data_refs["global/icon_enabled"].data
        );
        setConditional(
            element,
            setIconSize,
            new_value,
            custom_style_data_refs.icon_size.data,
            data_refs["global/icon_size"].data
        );
        setConditional(
            element,
            setPrimaryColor,
            new_value,
            custom_style_data_refs.primary_color.data,
            data_refs["global/primary_color"].data
        );
        setConditional(
            element,
            setSecondaryColor,
            new_value,
            custom_style_data_refs.secondary_color.data,
            data_refs["global/secondary_color"].data
        );
        setConditional(
            element,
            setPrimaryFont,
            new_value,
            custom_style_data_refs.primary_font.data,
            data_refs["global/primary_font"].data
        );
        setConditional(
            element,
            setSecondaryFont,
            new_value,
            custom_style_data_refs.secondary_font.data,
            data_refs["global/secondary_font"].data
        );
    });

    custom_style_data_refs.icon_enabled.dataChanged.connect(function (new_value) {
        setConditional(
            element,
            setIconEnabled,
            custom_style_data_refs.custom_style.data,
            new_value,
            data_refs["global/icon_enabled"].data
        );
    });

    custom_style_data_refs.icon_size.dataChanged.connect(function (new_value) {
        setConditional(
            element,
            setIconSize,
            custom_style_data_refs.custom_style.data,
            new_value,
            data_refs["global/icon_size"].data
        );
    });

    custom_style_data_refs.primary_color.dataChanged.connect(function (new_value) {
        setConditional(
            element,
            setPrimaryColor,
            custom_style_data_refs.custom_style.data,
            new_value,
            data_refs["global/primary_color"].data
        );
    });

    custom_style_data_refs.secondary_color.dataChanged.connect(function (new_value) {
        setConditional(
            element,
            setSecondaryColor,
            custom_style_data_refs.custom_style.data,
            new_value,
            data_refs["global/secondary_color"].data
        );
    });

    custom_style_data_refs.primary_font.dataChanged.connect(function (new_value) {
        setConditional(
            element,
            setPrimaryFont,
            custom_style_data_refs.custom_style.data,
            new_value,
            data_refs["global/primary_font"].data
        );
    });

    custom_style_data_refs.secondary_font.dataChanged.connect(function (new_value) {
        setConditional(
            element,
            setSecondaryFont,
            custom_style_data_refs.custom_style.data,
            new_value,
            data_refs["global/secondary_font"].data
        );
    });

    data_refs["global/icon_enabled"].dataChanged.connect(function (new_value) {
        setConditional(
            element,
            setIconEnabled,
            custom_style_data_refs.custom_style.data,
            custom_style_data_refs.icon_enabled.data,
            new_value
        );
    });

    data_refs["global/icon_size"].dataChanged.connect(function (new_value) {
        setConditional(
            element,
            setIconSize,
            custom_style_data_refs.custom_style.data,
            custom_style_data_refs.icon_size.data,
            new_value
        );
    });

    data_refs["global/primary_color"].dataChanged.connect(function (new_value) {
        setConditional(
            element,
            setPrimaryColor,
            custom_style_data_refs.custom_style.data,
            custom_style_data_refs.primary_color.data,
            new_value
        );
    });

    data_refs["global/secondary_color"].dataChanged.connect(function (new_value) {
        setConditional(
            element,
            setSecondaryColor,
            custom_style_data_refs.custom_style.data,
            custom_style_data_refs.secondary_color.data,
            new_value
        );
    });

    data_refs["global/primary_font"].dataChanged.connect(function (new_value) {
        setConditional(
            element,
            setPrimaryFont,
            custom_style_data_refs.custom_style.data,
            custom_style_data_refs.primary_font.data,
            new_value
        );
    });

    data_refs["global/secondary_font"].dataChanged.connect(function (new_value) {
        setConditional(
            element,
            setSecondaryFont,
            custom_style_data_refs.custom_style.data,
            custom_style_data_refs.secondary_font.data,
            new_value
        );
    });

}

function prependZeros(num, size) {
  let s = num+"";
  while (s.length < size) s = "0" + s;
  return s;
}

function connect(connected_callback) {
    let wsuri = "ws://localhost:45289";

    let socket = new WebSocket(wsuri);

    socket.onclose = function() {
        console.error("web channel closed");
        setTimeout(function(){connect(connected_callback)}, 1000);
    }
    socket.onerror = function(error) {
        console.error("web channel error: " + error);
    }
    socket.onopen = function () {
        new QWebChannel(socket, function (channel) {
            console.log(channel.objects);
            connected_callback(channel.objects);
        });
    }
}
