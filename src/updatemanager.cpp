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

#include "updatemanager.h"

#include <QJsonDocument>
#include <QJsonObject>
#include <QNetworkAccessManager>
#include <QNetworkReply>

#include "version.h"

bool newerVersion(int version_major, int version_minor, int version_patch) {
  if (version_major > VERSION_MAJOR)
    return true;
  else if (version_major == VERSION_MAJOR) {
    if (version_minor > VERSION_MINOR)
      return true;
    else if (version_minor == VERSION_MINOR) {
      if (version_patch > VERSION_PATCH)
        return true;
      else if (version_patch == VERSION_PATCH && VERSION_PRERELEASE)
        return true;
      else
        return false;
    } else
      return false;
  } else
    return false;
}

UpdateManager::UpdateManager(QObject *parent) : QObject(parent) {
  network_manager_ = new QNetworkAccessManager(this);

  connect(network_manager_, &QNetworkAccessManager::finished, this,
          &UpdateManager::handleReply);
}

QString UpdateManager::user() const { return user_; }

QString UpdateManager::repo() const { return repo_; }

void UpdateManager::handleReply(QNetworkReply *reply) {
  if (!reply->error()) {
    QJsonDocument json_doc = QJsonDocument::fromJson(reply->readAll());
    if (!json_doc.isNull()) {
      QJsonObject json_obj = json_doc.object();
      QString version_string = json_obj["tag_name"].toString();
      QString url = json_obj["html_url"].toString();
      QString body = json_obj["body"].toString();

      QStringList version_list = version_string.trimmed()
                                     .remove(QChar('v', Qt::CaseInsensitive))
                                     .split(QChar('.'));

      if (version_list.size() == 3) {
        int version_major = version_list[0].toInt();
        int version_minor = version_list[1].toInt();
        int version_patch = version_list[2].toInt();

        if (newerVersion(version_major, version_minor, version_patch)) {
          emit updateAvailable(version_string, body, url);
        }
      }
    }
  }
  reply->deleteLater();
}

void UpdateManager::checkForUpdate() {
  network_manager_->get(QNetworkRequest(
      QUrl(QString("https://api.github.com/repos/%1/%2/releases/latest")
               .arg(user_)
               .arg(repo_))));
}

void UpdateManager::setUser(const QString &user) {
  if (user_ != user) {
    user_ = user;
    emit userChanged(user_);
  }
}

void UpdateManager::setRepo(const QString &repo) {
  if (repo_ != repo) {
    repo_ = repo;
    emit repoChanged(repo_);
  }
}
