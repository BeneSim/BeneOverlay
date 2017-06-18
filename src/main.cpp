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

#include <QApplication>
#include <QQmlApplicationEngine>

#include <QQmlContext>

#include <QWebSocketServer>
#include <QWebChannel>
#include <QDebug>
#include <QTimer>
#include <QtMath>
#include <QDir>
#include <QDirIterator>
#include <QThread>

#include "websocketclientwrapper.h"
#include "websockettransport.h"

#include "version.h"
#include "datarefmanager.h"
#include "dataref.h"
#include "updatemanager.h"

#if defined(Q_OS_WIN) && !defined(TEST_MODE)
#include "flightsimconnector.h"
#endif


#include <functional>


#if defined(TEST_MODE)
std::function<void()> dataRefSweep(double duration, double from, double to, QObject *data_ref) {
    return [=]() {
        static QTime time;
        static double dt;

        dt += time.restart();
        double amplitude = (to - from) / 2;
        double offset = (to + from) / 2;

        double phi = 2 * M_PI * 1.0/duration * dt / 1000;

        double val = amplitude * qSin(phi) + offset;

        qobject_cast<DataRef*>(data_ref)->setData(val);

    };
}

std::function<void()> funSweep(double duration, double from, double to, std::function<void(int)> fun) {
    return [=]() {
        static QTime time;
        static double dt;

        dt += time.restart();
        double amplitude = (to - from) / 2;
        double offset = (to + from) / 2;

        double phi = 2 * M_PI * 1.0/duration * dt / 1000;

        double val = amplitude * qSin(phi) + offset;

        fun(val);

    };
}
#endif

bool copyFile(QString const &from, QString const &to) {

    if (QFile::exists(to)) {
        qDebug() << "File" << to << "already exists, calculating checksum...";

        QFile to_file(to);
        QByteArray to_hash;
        if (to_file.open(QFile::ReadOnly)) {
            QCryptographicHash cryptographic_hash(QCryptographicHash::Md5);
            if (cryptographic_hash.addData(&to_file)) {
                 to_hash = cryptographic_hash.result();
                 to_file.close();
            } else {
                qDebug() << "Error calculating checksum of file" << to;
                 to_file.close();
                return false;
            }
        } else {
            qDebug() << "Error opening file" << to;
            return false;
        }

        QFile from_file(from);
        QByteArray from_hash;
        if (from_file.open(QFile::ReadOnly)) {
            QCryptographicHash cryptographic_hash(QCryptographicHash::Md5);
            if (cryptographic_hash.addData(&from_file)) {
                 from_hash = cryptographic_hash.result();
                 from_file.close();
            } else {
                qDebug() << "Error calculating checksum of file" << from;
                 from_file.close();
                return false;
            }
        } else {
            qDebug() << "Error opening file" << from;
            return false;
        }

        if (from_hash != to_hash) {
            qDebug() << "Checksum mismatch" << from_hash.toHex() << "!=" << to_hash.toHex();
            qDebug() << "Installing correct version";
            if (QFile::remove(to)) {
                if (QFile::copy(from, to)) {
                    QFile::setPermissions(to, QFileDevice::ReadOwner | QFileDevice::WriteOwner);
                    return true;
                } else {
                    qDebug() << "Error copying file" << from << "to" << to;
                    return false;
                }
            } else {
                qDebug() << "Error removing file" << to;
                return false;
            }
        }
        return true;
    } else {
        qDebug() << "File does not exist, copying ...";
        if (QFile::copy(from, to)) {
            QFile::setPermissions(to, QFileDevice::ReadOwner | QFileDevice::WriteOwner);
            return true;
        } else {
            qDebug() << "Error copying file" << from << "to" << to;
            return false;
        }
    }

    return false;
}

bool installFiles() {
    QDir::current().mkdir("html");
    QDir html_dir(QDir::current().absoluteFilePath("html"));

    if (!html_dir.exists()) {
        return false;
    }

    QDir html_res_dir(":/html");

    QDirIterator it(html_res_dir, QDirIterator::Subdirectories);

    while (it.hasNext()) {
        it.next();
        QFileInfo file_info = it.fileInfo();
        QString rel_file_path = html_res_dir.relativeFilePath(file_info.absoluteFilePath());

        if (file_info.fileName() == "." || file_info.fileName() == "..") {
            continue;
        }

        if (file_info.isDir()) {
            qDebug() << "Creating directory" << file_info.fileName();
            if (html_dir.mkdir(rel_file_path)) {
                qDebug() << "Success!";
            } else if (QDir(html_dir.absoluteFilePath(rel_file_path)).exists()) {
                qDebug() << "Already exists!";
            } else {
                qDebug() << "Error!";
                return false;
            }
        } else {
            if (!copyFile(file_info.absoluteFilePath(), html_dir.absoluteFilePath(rel_file_path))) {
                return false;
            }
        }

    }

    if (html_dir.mkdir("images") || QDir(html_dir.absoluteFilePath("images")).exists()) {
        return copyFile(":/images/event-background.png", html_dir.absoluteFilePath("images/event-background.png"));
    } else {
        return false;
    }

    return true;
}

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QApplication app(argc, argv);

    if (!installFiles()) {
        QQmlApplicationEngine engine;
        engine.rootContext()->setContextProperty("TITLE", "Error installing files!");
        engine.rootContext()->setContextProperty("MESSAGE", "Make sure that you close all programs that access files of BeneOverlay (e.g. OBS)\nIf in doubt delete the html folder inside the BeneOverlay folder.");
        engine.rootContext()->setContextProperty("VERSION_STRING", VERSION_STRING);
        engine.load(QUrl(QLatin1String("qrc:/BOErrorDialog.qml")));

        return app.exec();
    }

    DataRefManager data_ref_manager;

    QWebSocketServer websocket_server("BeneOverlay Websocket Server", QWebSocketServer::NonSecureMode);

    if (!websocket_server.listen(
                qobject_cast<DataRef*>(data_ref_manager.getDataRef("global/listen_any"))->data().toBool() ? QHostAddress::Any : QHostAddress::LocalHost,
                45289)) {
        QQmlApplicationEngine engine;
        engine.rootContext()->setContextProperty("TITLE", "Error starting WebSocket Server!");
        engine.rootContext()->setContextProperty("MESSAGE", "Is another instance of BeneOverlay still opened?");
        engine.rootContext()->setContextProperty("VERSION_STRING", VERSION_STRING);
        engine.load(QUrl(QLatin1String("qrc:/BOErrorDialog.qml")));

        return app.exec();
    }


#if defined(Q_OS_WIN) && !defined(TEST_MODE)
    QThread *worker_thread = new QThread;
    FlightSimConnector *flight_sim_connector = new FlightSimConnector();

    flight_sim_connector->moveToThread(worker_thread);
    QObject::connect(worker_thread, SIGNAL(started()), flight_sim_connector, SLOT(start()));

    QObject::connect(&app, SIGNAL(aboutToQuit()), flight_sim_connector, SLOT(quit()));
    QObject::connect(flight_sim_connector, SIGNAL(finished()), worker_thread, SLOT(quit()));
    QObject::connect(flight_sim_connector, SIGNAL(finished()), flight_sim_connector, SLOT(deleteLater()));
    QObject::connect(worker_thread, SIGNAL(finished()), worker_thread, SLOT(deleteLater()));

    QObject::connect(flight_sim_connector, &FlightSimConnector::parsedIas, qobject_cast<DataRef*>(data_ref_manager.getDataRef("sim/ias")), &DataRef::setData);
    QObject::connect(flight_sim_connector, &FlightSimConnector::parsedGs, qobject_cast<DataRef*>(data_ref_manager.getDataRef("sim/gs")), &DataRef::setData);
    QObject::connect(flight_sim_connector, &FlightSimConnector::parsedHdg, qobject_cast<DataRef*>(data_ref_manager.getDataRef("sim/hdg")), &DataRef::setData);
    QObject::connect(flight_sim_connector, &FlightSimConnector::parsedPitch, qobject_cast<DataRef*>(data_ref_manager.getDataRef("sim/pitch")), &DataRef::setData);
    QObject::connect(flight_sim_connector, &FlightSimConnector::parsedBank, qobject_cast<DataRef*>(data_ref_manager.getDataRef("sim/bank")), &DataRef::setData);
    QObject::connect(flight_sim_connector, &FlightSimConnector::parsedAltitude, qobject_cast<DataRef*>(data_ref_manager.getDataRef("sim/alt")), &DataRef::setData);
    QObject::connect(flight_sim_connector, &FlightSimConnector::parsedVs, qobject_cast<DataRef*>(data_ref_manager.getDataRef("sim/vs")), &DataRef::setData);
    QObject::connect(flight_sim_connector, &FlightSimConnector::parsedWindDir, qobject_cast<DataRef*>(data_ref_manager.getDataRef("sim/wind_dir")), &DataRef::setData);
    QObject::connect(flight_sim_connector, &FlightSimConnector::parsedWindMag, qobject_cast<DataRef*>(data_ref_manager.getDataRef("sim/wind_mag")), &DataRef::setData);
    QObject::connect(flight_sim_connector, &FlightSimConnector::parsedLatitude, qobject_cast<DataRef*>(data_ref_manager.getDataRef("sim/lat")), &DataRef::setData);
    QObject::connect(flight_sim_connector, &FlightSimConnector::parsedLongitude, qobject_cast<DataRef*>(data_ref_manager.getDataRef("sim/long")), &DataRef::setData);
    QObject::connect(flight_sim_connector, &FlightSimConnector::parsedFps, &data_ref_manager, &DataRefManager::setFPS);
    QObject::connect(flight_sim_connector, &FlightSimConnector::parsedGearDown, qobject_cast<DataRef*>(data_ref_manager.getDataRef("sim/gear_down")), &DataRef::setData);
    QObject::connect(flight_sim_connector, &FlightSimConnector::parsedOnGround, qobject_cast<DataRef*>(data_ref_manager.getDataRef("sim/on_ground")), &DataRef::setData);
    QObject::connect(flight_sim_connector, &FlightSimConnector::parsedOat, qobject_cast<DataRef*>(data_ref_manager.getDataRef("sim/oat")), &DataRef::setData);
    QObject::connect(flight_sim_connector, &FlightSimConnector::parsedTat, qobject_cast<DataRef*>(data_ref_manager.getDataRef("sim/tat")), &DataRef::setData);
    QObject::connect(flight_sim_connector, &FlightSimConnector::connectedChanged, qobject_cast<DataRef*>(data_ref_manager.getDataRef("sim/connected")), &DataRef::setData);
    QObject::connect(flight_sim_connector, &FlightSimConnector::parsedVasUsage, qobject_cast<DataRef*>(data_ref_manager.getDataRef("sim/vas")), &DataRef::setData);

    QObject::connect(qobject_cast<DataRef*>(data_ref_manager.getDataRef("global/data_rate")), &DataRef::dataChanged, flight_sim_connector, &FlightSimConnector::setDataRate);

    // The notify signal that gets called from the constructor won't reach the flight_sim_connector
    flight_sim_connector->setDataRate(qobject_cast<DataRef*>(data_ref_manager.getDataRef("global/data_rate"))->data());

    worker_thread->start();
#endif

    QObject::connect(&app, &QCoreApplication::aboutToQuit, &data_ref_manager, &DataRefManager::saveDataRefs);


#if defined(TEST_MODE)

    QTimer timer;

    QObject::connect(&timer, &QTimer::timeout, dataRefSweep(8.0, 0.0, 400.0, data_ref_manager.getDataRef("sim/ias")));
    QObject::connect(&timer, &QTimer::timeout, dataRefSweep(6.0, 0.0, 300.0, data_ref_manager.getDataRef("sim/gs")));
    QObject::connect(&timer, &QTimer::timeout, dataRefSweep(8.0, 0.0, 360.0, data_ref_manager.getDataRef("sim/hdg")));
    QObject::connect(&timer, &QTimer::timeout, dataRefSweep(8.0, -1000.0, 41000.0, data_ref_manager.getDataRef("sim/alt")));
    QObject::connect(&timer, &QTimer::timeout, dataRefSweep(8.0, -5000.0, 5000.0, data_ref_manager.getDataRef("sim/vs")));
    QObject::connect(&timer, &QTimer::timeout, dataRefSweep(8.0, 0.0, 360.0, data_ref_manager.getDataRef("sim/wind_dir")));
    QObject::connect(&timer, &QTimer::timeout, dataRefSweep(8.0, 0.0, 150.0, data_ref_manager.getDataRef("sim/wind_mag")));
    QObject::connect(&timer, &QTimer::timeout, dataRefSweep(8.0, -70.0, 50.0, data_ref_manager.getDataRef("sim/oat")));
    QObject::connect(&timer, &QTimer::timeout, dataRefSweep(8.0, -70.0, 50.0, data_ref_manager.getDataRef("sim/tat")));
    QObject::connect(&timer, &QTimer::timeout, dataRefSweep(8.0, 0, 5000, data_ref_manager.getDataRef("sim/vas")));

    QObject::connect(&timer, &QTimer::timeout, funSweep(8.0, 0.0, 130.0, [&data_ref_manager](int val) { data_ref_manager.setFPS(val);}));

    QObject::connect(&timer, &QTimer::timeout, dataRefSweep(8.0, -10.0, 10.0, data_ref_manager.getDataRef("sim/pitch")));
    QObject::connect(&timer, &QTimer::timeout, dataRefSweep(7.0, -4.0, 4.0, data_ref_manager.getDataRef("sim/bank")));
    QObject::connect(&timer, &QTimer::timeout, dataRefSweep(3.0, 0.0, 1.0, data_ref_manager.getDataRef("sim/connected")));
    QObject::connect(&timer, &QTimer::timeout, dataRefSweep(3.0, 0.0, 1.0, data_ref_manager.getDataRef("sim/gear_down")));
    QObject::connect(&timer, &QTimer::timeout, dataRefSweep(10.0, 0.0, 1.0, data_ref_manager.getDataRef("sim/on_ground")));
    QObject::connect(&timer, &QTimer::timeout, dataRefSweep(10.0, 0.0, 3000.0, data_ref_manager.getDataRef("flight/distance_to_destination")));
    timer.start(1000/25);

#endif

    WebSocketClientWrapper client_wrapper(&websocket_server);

    QWebChannel web_channel;

    QObject::connect(&client_wrapper, &WebSocketClientWrapper::clientConnected, &web_channel, &QWebChannel::connectTo);

    QHash<QString, QObject*> data_ref_map = data_ref_manager.dataRefMap();

    web_channel.registerObjects(data_ref_map);

    QQmlApplicationEngine engine;
    qmlRegisterUncreatableType<DataRef>("org.benesim.types", 1, 0, "DataRef", "Not instantiatable");
    qmlRegisterType<UpdateManager>("org.benesim.types", 1, 0, "UpdateManager");
    engine.rootContext()->setContextProperty("data_ref_manager", &data_ref_manager);
    engine.rootContext()->setContextProperty("VERSION_MAJOR", VERSION_MAJOR);
    engine.rootContext()->setContextProperty("VERSION_MINOR", VERSION_MINOR);
    engine.rootContext()->setContextProperty("VERSION_PATCH", VERSION_PATCH);
    engine.rootContext()->setContextProperty("VERSION_PRERELEASE", VERSION_PRERELEASE);
    engine.rootContext()->setContextProperty("VERSION_STRING", VERSION_STRING);
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));

    return app.exec();
}
