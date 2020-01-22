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

#ifndef UPDATEMANAGER_H
#define UPDATEMANAGER_H

#include <QObject>

class QNetworkAccessManager;
class QNetworkReply;

class UpdateManager : public QObject {
  Q_OBJECT
  Q_PROPERTY(QString user READ user WRITE setUser NOTIFY userChanged)
  Q_PROPERTY(QString repo READ repo WRITE setRepo NOTIFY repoChanged)
public:
  explicit UpdateManager(QObject *parent = 0);

  QString user() const;
  QString repo() const;

private:
  QNetworkAccessManager *network_manager_;

  QString user_;
  QString repo_;

signals:
  void updateAvailable(QString const &version_string, QString const &body,
                       QString const &download_url);
  void userChanged(QString const &user);
  void repoChanged(QString const &repo);

private slots:
  void handleReply(QNetworkReply *reply);

public slots:
  void checkForUpdate();
  void setUser(QString const &user);
  void setRepo(QString const &repo);
};

#endif // UPDATEMANAGER_H
