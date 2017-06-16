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

#include "datarefmanager.h"
#include "dataref.h"

#include <QDebug>
#include <QSettings>
#include <QColor>
#include <QFont>
#include <QFile>
#include <QtMath>
#include <QDateTime>
#include <QDir>

double greatCircleDistance(double lat1, double long1, double lat2, double long2) {
    const double mean_earth_r = 6371008.8 * 90.0 * 60.0 / 10001966.0;

    lat1 = qDegreesToRadians(lat1);
    lat2 = qDegreesToRadians(lat2);
    double dlat = qAbs(lat1 - lat2);

    long1 = qDegreesToRadians(long1);
    long2 = qDegreesToRadians(long2);
    double dlong = qAbs(long1 - long2);

    double ds = 2.0 * qAsin(qSqrt(qPow(qSin(dlat/2.0),2.0) + qCos(lat1) * qCos(lat2) * qPow(qSin(dlong/2.0),2.0)));

    return mean_earth_r * ds;
}

int fps_buffer_idx = 0;

DataRefManager::DataRefManager(QObject *parent) : QObject(parent)
{
    data_ref_map_["sim/ias"] = new DataRef(0, false, this);
    data_ref_map_["sim/gs"] = new DataRef(0, false, this);
    data_ref_map_["sim/hdg"] = new DataRef(0, false, this);
    data_ref_map_["sim/alt"] = new DataRef(0, false, this);
    data_ref_map_["sim/vs"] = new DataRef(0, false, this);
    data_ref_map_["sim/pitch"] = new DataRef(0, false, this);
    data_ref_map_["sim/gear_down"] = new DataRef(true, false, this);
    data_ref_map_["sim/wind_dir"] = new DataRef(0, false, this);
    data_ref_map_["sim/wind_mag"] = new DataRef(0, false, this);
    data_ref_map_["sim/fps_mean"] = new DataRef(0, false, this);
    data_ref_map_["sim/on_ground"] = new DataRef(true, false, this);
    data_ref_map_["sim/bank"] = new DataRef(0, false, this);
    data_ref_map_["sim/lat"] = new DataRef(0.0, false, this);
    data_ref_map_["sim/long"] = new DataRef(0.0, false, this);
    data_ref_map_["sim/oat"] = new DataRef(0, false, this);
    data_ref_map_["sim/tat"] = new DataRef(0, false, this);
    data_ref_map_["sim/connected"] = new DataRef(false, false, this);

    data_ref_map_["flight/airline"] = new DataRef("Global Wings", true, this);
    data_ref_map_["flight/airline_icao"] = new DataRef("GLW", true, this);
    data_ref_map_["flight/flight_number"] = new DataRef("568A", true, this);
    data_ref_map_["flight/aircraft_icao"] = new DataRef("B738", true, this);
    data_ref_map_["flight/departure_icao"] = new DataRef("EDDT", true, this);
    data_ref_map_["flight/arrival_icao"] = new DataRef("LSZH", true, this);
    data_ref_map_["flight/route"] = new DataRef("BRANE Q201 BUREL UM736 TABAT UL87 ANELA UN869 TEDGO T724 RILAX	", true, this);
    data_ref_map_["flight/network"] = new DataRef("IVAO", true, this);
    data_ref_map_["flight/transition_altitude"] = new DataRef(5000, true, this);
    data_ref_map_["flight/max_ias"] = new DataRef(300, true, this);
    data_ref_map_["flight/cruise_altitude"] = new DataRef(36000, true, this);
    data_ref_map_["flight/route_distance"] = new DataRef(0, true, this);
    data_ref_map_["flight/distance_to_destination"] = new DataRef(0, true, this);
    data_ref_map_["flight/eta"] = new DataRef("--:--", true, this);

    data_ref_map_["global/icon_enabled"] = new DataRef(true, true, this);
    data_ref_map_["global/icon_size"] = new DataRef(70, true, this);
    data_ref_map_["global/primary_color"] = new DataRef(QColor("#ffffff"), true, this);
    data_ref_map_["global/secondary_color"] = new DataRef(QColor("#f44336"), true, this);
    data_ref_map_["global/primary_font"] = new DataRef(QFont(), true, this);
    data_ref_map_["global/secondary_font"] = new DataRef(QFont(), true, this);
    data_ref_map_["global/data_rate"] = new DataRef(10, true, this);
    data_ref_map_["global/listen_any"] = new DataRef(false, true, this);

    data_ref_map_["widget/callsign/enabled"] = new DataRef(true, true, this);
    data_ref_map_["widget/callsign/custom_style"] = new DataRef(false, true, this);
    data_ref_map_["widget/callsign/icon_enabled"] = new DataRef(true, true, this);
    data_ref_map_["widget/callsign/icon_size"] = new DataRef(70, true, this);
    data_ref_map_["widget/callsign/primary_color"] = new DataRef(QColor("#ffffff"), true, this);
    data_ref_map_["widget/callsign/secondary_color"] = new DataRef(QColor("#f44336"), true, this);
    data_ref_map_["widget/callsign/primary_font"] = new DataRef(QFont(), true, this);
    data_ref_map_["widget/callsign/secondary_font"] = new DataRef(QFont(), true, this);

    data_ref_map_["widget/network/enabled"] = new DataRef(true, true, this);
    data_ref_map_["widget/network/custom_style"] = new DataRef(false, true, this);
    data_ref_map_["widget/network/icon_enabled"] = new DataRef(true, true, this);
    data_ref_map_["widget/network/icon_size"] = new DataRef(70, true, this);
    data_ref_map_["widget/network/primary_color"] = new DataRef(QColor("#ffffff"), true, this);
    data_ref_map_["widget/network/secondary_color"] = new DataRef(QColor("#f44336"), true, this);
    data_ref_map_["widget/network/primary_font"] = new DataRef(QFont(), true, this);
    data_ref_map_["widget/network/secondary_font"] = new DataRef(QFont(), true, this);

    data_ref_map_["widget/speed/enabled"] = new DataRef(true, true, this);
    data_ref_map_["widget/speed/custom_style"] = new DataRef(false, true, this);
    data_ref_map_["widget/speed/icon_enabled"] = new DataRef(true, true, this);
    data_ref_map_["widget/speed/icon_size"] = new DataRef(70, true, this);
    data_ref_map_["widget/speed/primary_color"] = new DataRef(QColor("#ffffff"), true, this);
    data_ref_map_["widget/speed/secondary_color"] = new DataRef(QColor("#f44336"), true, this);
    data_ref_map_["widget/speed/primary_font"] = new DataRef(QFont(), true, this);
    data_ref_map_["widget/speed/secondary_font"] = new DataRef(QFont(), true, this);

    data_ref_map_["widget/heading/enabled"] = new DataRef(true, true, this);
    data_ref_map_["widget/heading/custom_style"] = new DataRef(false, true, this);
    data_ref_map_["widget/heading/icon_enabled"] = new DataRef(true, true, this);
    data_ref_map_["widget/heading/icon_size"] = new DataRef(70, true, this);
    data_ref_map_["widget/heading/primary_color"] = new DataRef(QColor("#ffffff"), true, this);
    data_ref_map_["widget/heading/secondary_color"] = new DataRef(QColor("#f44336"), true, this);
    data_ref_map_["widget/heading/primary_font"] = new DataRef(QFont(), true, this);
    data_ref_map_["widget/heading/secondary_font"] = new DataRef(QFont(), true, this);
    data_ref_map_["widget/heading/prepend_zeros"] = new DataRef(true, true, this);

    data_ref_map_["widget/altitude/enabled"] = new DataRef(true, true, this);
    data_ref_map_["widget/altitude/custom_style"] = new DataRef(false, true, this);
    data_ref_map_["widget/altitude/icon_enabled"] = new DataRef(true, true, this);
    data_ref_map_["widget/altitude/icon_size"] = new DataRef(70, true, this);
    data_ref_map_["widget/altitude/primary_color"] = new DataRef(QColor("#ffffff"), true, this);
    data_ref_map_["widget/altitude/secondary_color"] = new DataRef(QColor("#f44336"), true, this);
    data_ref_map_["widget/altitude/primary_font"] = new DataRef(QFont(), true, this);
    data_ref_map_["widget/altitude/secondary_font"] = new DataRef(QFont(), true, this);

    data_ref_map_["widget/wind/enabled"] = new DataRef(true, true, this);
    data_ref_map_["widget/wind/custom_style"] = new DataRef(false, true, this);
    data_ref_map_["widget/wind/icon_enabled"] = new DataRef(true, true, this);
    data_ref_map_["widget/wind/icon_size"] = new DataRef(70, true, this);
    data_ref_map_["widget/wind/primary_color"] = new DataRef(QColor("#ffffff"), true, this);
    data_ref_map_["widget/wind/secondary_color"] = new DataRef(QColor("#f44336"), true, this);
    data_ref_map_["widget/wind/primary_font"] = new DataRef(QFont(), true, this);
    data_ref_map_["widget/wind/secondary_font"] = new DataRef(QFont(), true, this);
    data_ref_map_["widget/wind/prepend_zeros"] = new DataRef(true, true, this);

    data_ref_map_["widget/performance/enabled"] = new DataRef(true, true, this);
    data_ref_map_["widget/performance/custom_style"] = new DataRef(false, true, this);
    data_ref_map_["widget/performance/icon_enabled"] = new DataRef(true, true, this);
    data_ref_map_["widget/performance/icon_size"] = new DataRef(70, true, this);
    data_ref_map_["widget/performance/primary_color"] = new DataRef(QColor("#ffffff"), true, this);
    data_ref_map_["widget/performance/secondary_color"] = new DataRef(QColor("#f44336"), true, this);
    data_ref_map_["widget/performance/primary_font"] = new DataRef(QFont(), true, this);
    data_ref_map_["widget/performance/secondary_font"] = new DataRef(QFont(), true, this);
    data_ref_map_["widget/performance/fps_buffer_size"] = new DataRef(1, true, this);

    data_ref_map_["widget/temperature/enabled"] = new DataRef(true, true, this);
    data_ref_map_["widget/temperature/custom_style"] = new DataRef(false, true, this);
    data_ref_map_["widget/temperature/icon_enabled"] = new DataRef(true, true, this);
    data_ref_map_["widget/temperature/icon_size"] = new DataRef(70, true, this);
    data_ref_map_["widget/temperature/primary_color"] = new DataRef(QColor("#ffffff"), true, this);
    data_ref_map_["widget/temperature/secondary_color"] = new DataRef(QColor("#f44336"), true, this);
    data_ref_map_["widget/temperature/primary_font"] = new DataRef(QFont(), true, this);
    data_ref_map_["widget/temperature/secondary_font"] = new DataRef(QFont(), true, this);
    data_ref_map_["widget/temperature/tat_enabled"] = new DataRef(true, true, this);

    data_ref_map_["progress/custom_style"] = new DataRef(false, true, this);
    data_ref_map_["progress/icon_enabled"] = new DataRef(true, true, this);
    data_ref_map_["progress/icon_size"] = new DataRef(70, true, this);
    data_ref_map_["progress/primary_color"] = new DataRef(QColor("#ffffff"), true, this);
    data_ref_map_["progress/secondary_color"] = new DataRef(QColor("#f44336"), true, this);
    data_ref_map_["progress/primary_font"] = new DataRef(QFont(), true, this);
    data_ref_map_["progress/secondary_font"] = new DataRef(QFont(), true, this);

    data_ref_map_["landing/settings_mode"] = new DataRef(false, true, this);
    data_ref_map_["landing/background_image_enabled"] = new DataRef(true, true, this);
    data_ref_map_["landing/background_image"] = new DataRef("file:///" + QDir::current().absoluteFilePath("html/images/event-background.png"), true, this);
    data_ref_map_["landing/popup_duration"] = new DataRef(8, true, this);
    data_ref_map_["landing/custom_style"] = new DataRef(false, true, this);
    data_ref_map_["landing/icon_enabled"] = new DataRef(true, true, this);
    data_ref_map_["landing/icon_size"] = new DataRef(70, true, this);
    data_ref_map_["landing/primary_color"] = new DataRef(QColor("#ffffff"), true, this);
    data_ref_map_["landing/secondary_color"] = new DataRef(QColor("#f44336"), true, this);
    data_ref_map_["landing/primary_font"] = new DataRef(QFont(), true, this);
    data_ref_map_["landing/secondary_font"] = new DataRef(QFont(), true, this);

    // Load airport data
    QFile file(":data/airports.csv");

    if (file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        QString data = file.readAll();
        data.remove("\r");

        QTextStream in(&data);
        in.setCodec("UTF-8");

        QChar character;

        QString temp;
        QStringList columns;

        while (!in.atEnd()) {
            in >> character;
            if (temp.count("\"") % 2 == 0 && character == QChar(',')) {
                columns.append(temp.remove(QChar('"')));
                temp.clear();
            } else if (character == QChar('\n')) {
                columns.append(temp.remove(QChar('"')));
                temp.clear();
                airports_[columns[1]] = QList<QVariant>{columns[3], columns[4].toDouble(), columns[5].toDouble()};
            columns.clear();
        }
        else {
            temp.append(character);
        }
    }
}

connect(qobject_cast<DataRef*>(data_ref_map_["flight/departure_icao"]), &DataRef::dataChanged, this, &DataRefManager::calcRouteDistance);
connect(qobject_cast<DataRef*>(data_ref_map_["flight/arrival_icao"]), &DataRef::dataChanged, this, &DataRefManager::calcRouteDistance);
connect(qobject_cast<DataRef*>(data_ref_map_["flight/arrival_icao"]), &DataRef::dataChanged, this, &DataRefManager::calcDistanceToDestination);
connect(qobject_cast<DataRef*>(data_ref_map_["sim/lat"]), &DataRef::dataChanged, this, &DataRefManager::calcDistanceToDestination);
connect(qobject_cast<DataRef*>(data_ref_map_["sim/long"]), &DataRef::dataChanged, this, &DataRefManager::calcDistanceToDestination);

connect(qobject_cast<DataRef*>(data_ref_map_["sim/gs"]), &DataRef::dataChanged, this, &DataRefManager::calcETA);
connect(qobject_cast<DataRef*>(data_ref_map_["sim/on_ground"]), &DataRef::dataChanged, this, &DataRefManager::calcETA);
connect(qobject_cast<DataRef*>(data_ref_map_["flight/departure_icao"]), &DataRef::dataChanged, this, &DataRefManager::calcETA);

connect(qobject_cast<DataRef*>(data_ref_map_["widget/performance/fps_buffer_size"]), &DataRef::dataChanged, this, &DataRefManager::updateFPSBufferSize);

loadDataRefs();

calcRouteDistance();
calcDistanceToDestination();
updateFPSBufferSize();

}


QObject *DataRefManager::getDataRef(const QString &name)
{
    //qDebug() << "Request for " << name;
    return data_ref_map_.value(name);
}

QHash<QString, QObject *> DataRefManager::dataRefMap()
{
    return data_ref_map_;
}

void DataRefManager::loadDataRefs()
{
    QSettings settings("beneoverlay.conf", QSettings::IniFormat);
    for (QString const &name : data_ref_map_.keys()) {
        DataRef *data_ref = qobject_cast<DataRef*>(data_ref_map_[name]);
        if (data_ref->saveable() && settings.contains(name)) {
            qDebug() << "Loading " << name << " type " << data_ref->data().typeName();
            data_ref->setData(settings.value(name));
        }
    }
}

void DataRefManager::saveDataRefs()
{
    QSettings settings("beneoverlay.conf", QSettings::IniFormat);
    for (QString const &name : data_ref_map_.keys()) {
        DataRef *data_ref = qobject_cast<DataRef*>(data_ref_map_[name]);
        if (data_ref->saveable()) {
            qDebug() << "Saving " << name;
            settings.setValue(name, data_ref->data());
        }
    }

    qDebug() << settings.fileName();
}

void DataRefManager::calcRouteDistance()
{
    QString origin = qobject_cast<DataRef*>(data_ref_map_["flight/departure_icao"])->data().toString();
    QString destination = qobject_cast<DataRef*>(data_ref_map_["flight/arrival_icao"])->data().toString();

    double route_distance = 0.0;

    if (!origin.isEmpty() && !destination.isEmpty()) {
        if (airports_.contains(origin) && airports_.contains(destination)) {
            double lat1 = airports_[origin][1].toDouble();
            double long1 = airports_[origin][2].toDouble();
            double lat2 = airports_[destination][1].toDouble();
            double long2 = airports_[destination][2].toDouble();

            route_distance = greatCircleDistance(lat1, long1, lat2, long2);
        }
    }

    qobject_cast<DataRef*>(data_ref_map_["flight/route_distance"])->setData(route_distance);
}

void DataRefManager::calcDistanceToDestination()
{
    QString destination = qobject_cast<DataRef*>(data_ref_map_["flight/arrival_icao"])->data().toString();
    double latitude = qobject_cast<DataRef*>(data_ref_map_["sim/lat"])->data().toDouble();
    double longitude = qobject_cast<DataRef*>(data_ref_map_["sim/long"])->data().toDouble();

    double distance_to_destination = 0.0;

    if (!destination.isEmpty() && airports_.contains(destination)) {
        double lat1 = airports_[destination][1].toDouble();
        double long1 = airports_[destination][2].toDouble();

        distance_to_destination = greatCircleDistance(lat1, long1, latitude, longitude);
    }

    qobject_cast<DataRef*>(data_ref_map_["flight/distance_to_destination"])->setData(distance_to_destination);
}

void DataRefManager::calcETA()
{
    double gs = qobject_cast<DataRef*>(data_ref_map_["sim/gs"])->data().toInt();

    double on_ground = qobject_cast<DataRef*>(data_ref_map_["sim/on_ground"])->data().toBool();

    QString eta = "--:--";


    if (!on_ground && gs > 5) {
        QDateTime current_date_time = QDateTime::currentDateTimeUtc();
        double distance_to_destination = qobject_cast<DataRef*>(data_ref_map_["flight/distance_to_destination"])->data().toDouble();

        double dt = distance_to_destination / gs * 60 * 60;


        current_date_time = current_date_time.addSecs(dt);

        eta = current_date_time.toString("HH:mm");

    }

    qobject_cast<DataRef*>(data_ref_map_["flight/eta"])->setData(eta);

}

void DataRefManager::setFPS(int fps)
{
    if (fps_buffer_idx >= fps_buffer_.size()) {
        int fps_mean = 0;
        for (int fps : fps_buffer_) {
            fps_mean += fps;
        }

        fps_mean /= fps_buffer_.size() > 0 ? fps_buffer_.size() : 1;

        fps_buffer_idx = 0;

        qobject_cast<DataRef*>(data_ref_map_["sim/fps_mean"])->setData(fps_mean);
    }

    fps_buffer_[fps_buffer_idx] = fps;
    ++fps_buffer_idx;
}

void DataRefManager::updateFPSBufferSize()
{
    int fps_buffer_size = qobject_cast<DataRef*>(data_ref_map_["widget/performance/fps_buffer_size"])->data().toInt();

    if (fps_buffer_.size() != fps_buffer_size && fps_buffer_size > 0) {
        fps_buffer_.resize(fps_buffer_size);
    }
}












