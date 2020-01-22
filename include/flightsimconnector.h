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

#ifndef FLIGHTSIMCONNECTOR_H
#define FLIGHTSIMCONNECTOR_H

#include <QObject>
#include <QTimer>

class FlightSimConnector : public QObject {
  Q_OBJECT
  Q_PROPERTY(
      bool connected READ connected WRITE setConnected NOTIFY connectedChanged)
public:
  explicit FlightSimConnector(QObject *parent = 0);
  virtual ~FlightSimConnector();

  bool connected() const;
  void setConnected(bool connected);

signals:
  void connectedChanged(bool connected);
  void finished();

  void parsedIas(double ias);
  void parsedGs(double gs);
  void parsedTas(double tas);
  void parsedMach(double gs);
  void parsedHdg(double hdg);
  void parsedTrk(double trk);
  void parsedAltitude(double altitude);
  void parsedVs(double vs);
  void parsedWindDir(double wind_dir);
  void parsedWindMag(double wind_mag);
  void parsedVasUsage(int vas_usage);
  void parsedLatitude(double latitude);
  void parsedLongitude(double longitude);
  void parsedFps(int fps);
  void parsedGearDown(bool gear_down);
  void parsedPitch(double pitch);
  void parsedVsAir(double vs_air);
  void parsedBank(double bank);
  void parsedOnGround(bool on_ground);
  void parsedOat(int oat);
  void parsedTat(int tat);

public slots:
  void start();
  void quit();
  void connectFS();
  void disconnectFS();
  void pollData();

  void setDataRate(QVariant const &data_rate);

private:
  template <typename T, size_t n> bool pollValue(int offset, T &value);

  bool _connected;
  int _data_rate;
  QTimer *_connect_fs_timer;
  QTimer *_poll_data_timer;
};

#endif // FLIGHTSIMCONNECTOR_H
