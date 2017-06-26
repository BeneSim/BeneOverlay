import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

ApplicationWindow {
    id: root
    visible: true
    width: 600
    height: 750
    title: "BeneOverlay v" + VERSION_STRING

    BOWidgetSettings {
        anchors.fill: parent
        label: "Hallo"

        Repeater {
            model: 10
            delegate: BOSwitch {
                label: "Hallo " + index
            }
        }
    }

}
