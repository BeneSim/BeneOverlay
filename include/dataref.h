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

#ifndef DATAREF_H
#define DATAREF_H

#include <QObject>
#include <QVariant>

class DataRef : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QVariant data READ data WRITE setData NOTIFY dataChanged)
    Q_PROPERTY(bool saveable READ saveable NOTIFY saveableChanged)
public:
    explicit DataRef(QVariant data, bool saveable = false, QObject *parent = 0);

    QVariant data() const;
    bool saveable() const;

private:
    QVariant data_;
    bool saveable_;

signals:
    void dataChanged(QVariant const &data);
    void saveableChanged(bool saveable);

public slots:
    void setData(QVariant const &data);
};


#endif // DATAREF_H
