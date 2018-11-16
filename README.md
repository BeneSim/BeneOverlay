# Download (Binaries)
Direkt link to the latest Version: [BeneOverlay v1.2.0](https://github.com/BeneSim/BeneOverlay/releases/download/v1.2.0/BeneOverlay.v1.2.0.zip)

<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-refresh-toc -->
**Table of Contents**

- [About](#about)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
    - [OBS Studio Setup](#obs-studio-setup)
- [Usage](#usage)
- [License](#license)

<!-- markdown-toc end -->


# About
BeneOverlay by BeneSim is free software distributed under the GNU General Public
License, Version 3.
It was designed to enhance the experience for viewers of flight sim streams.
Often times it is very hard to see some of the interesting data of the current
flight, like altitude, heading and speed. In fact, if you are not inside the
virtual cockpit it might even be impossible to get hold of these information.

This is where BeneOverlay comes into play. It uses the FSUIPC SDK to communicate
with your favorite flight sim and extracts all the important data and embeds
them into a website. By simply including this website into your preferred
streaming client you're viewers are always aware of what's going on in the sim.

# Prerequisites
Since BeneOverlay uses the FSUIPC SDK to communicate with the flight sim, you
need to have FSUIPC (FSX/P3D) or XPUIPC (XP10/11) installed. The unregistered
version of FSUIPC is sufficient.

- [Download FSUIPC (FSX/P3D)](http://www.schiratti.com/dowson.html)
- [Download XPUIPC (XP10/11)](http://www.tosi-online.de/XPUIPC/XPUIPC.html)

# Installation
I created a video that explains the installation process in detail. To view it
just click on the image below.

[![BeneOverlay - Installation & Setup Guide](https://img.youtube.com/vi/hOWkNvn7TkU/0.jpg)](https://www.youtube.com/watch?v=hOWkNvn7TkU "BeneOverlay - Installation & Setup Guide")

BeneOverlay ships as a `*.zip` file. Simply unzip the file to a directory of
your liking. No installation required. Once unzipped run `BeneOverlay.exe`. On
first start it will create a `html` folder. Within this `html` folder are the
`*.html` files you want to include in your streaming software. 

* `widgets.html` This is the main widget. It displays all kinds of information
like heading, altitude, speed etc.
* `progress.html` Displays your departure and arrival airport. The distance
between those airports and the distance to go as well as the ETA.
* `landing.html` Displays you vertical speed, pitch, bank and speed on touchdown
* `*.html` All other file are the individual widgets found in `widgets.html`. If
you prefer to include and position each widget individually feel free to do so.

BeneOverlay has been extensively tested with OBS Studio, thus I highly
recommend to use it as your streaming software.

## OBS Studio Setup
In order to render `*.html` files in OBS Studio you need the **BrowserPlugin**.
In recent versions of OBS Studio the **BrowserPlugin** will be installed by
default.

Adding the BeneOverlay `*.html` files is straight forward. With OBS Studio
opened locate the `Sources` tab and click on `Add` (indicated by a `+`). Select
`Browser Source`, select `Create new`, chose a meaningful name e.g.
`beneoverlay-widgets` and click on `OK`.

In the config dialog check `Local file`
and browse to the html file you want to add e.g. `widgets.html`. Now select and
copy the contents of the `Local file` field. Uncheck `Local file` and paste the
previously copied file path into the `URL` field.  
Technically all `*.html` files
of BeneOverlay can be included as local files. However, the `landing.html` must
not be included as a local file, else selecting a background image would have
no effect.  
Now enter the desired `width` and `height` of the widget and click `OK`. I
recommend to chose the size generously. Scaling of the widgets should be
performed within the BeneOverlay software itself and not within OBS Studio using
the `Icon Size` and `Font` settings.

A final step would be to drag the widgets on the scene to the positions you
prefer.

# Usage
The GUI should be pretty self explanatory. I might include a manual in future
versions. If you need help using the software feel free to contact me. The best
place would be my discord server.

[BeneSim Discord Server](https://discord.gg/nkwz4Dg)

# License
BeneOverlay is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

BeneOverlay is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with BeneOverlay. If not, see <http://www.gnu.org/licenses/>.
