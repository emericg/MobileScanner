import QtQuick
import QtQuick.Controls

import ThemeEngine 1.0

Column {
    id: screensCol
    anchors.bottom: bottomemnu.top
    anchors.bottomMargin: Theme.componentMarginXL
    anchors.right: bottomemnu.right

    width: singleColumn ? screenBarcodeReader.width - Theme.componentMarginXL*2 : 320
    spacing: Theme.componentMargin
    visible: false

    Repeater {
        model: ListModel {
            ListElement { idx: 1; txt: "Barcode scanner"; src: "qrc:/assets/icons_material/duotone-qr_code_scanner-24px.svg"; }
            ListElement { idx: 2; txt: "Barcode generator"; src: "qrc:/assets/icons_material/baseline-qr_code_2-24px.svg"; }
            ListElement { idx: 3; txt: "Barcode history"; src: "qrc:/assets/icons_material/duotone-list-24px.svg"; }
            ListElement { idx: 4; txt: "Settings"; src: "qrc:/assets/icons_material/outline-settings-24px.svg"; }
            ListElement { idx: 5; txt: "About"; src: "qrc:/assets/icons_material/outline-info-24px.svg"; }
        }

        Item {
            width: parent.width
            height: 40

            Rectangle {
                anchors.fill: parent
                radius: 24
                color: "black"
                opacity: 0.33
            }

            Text {
                anchors.left: parent.left
                anchors.leftMargin: Theme.componentMargin
                anchors.verticalCenter: parent.verticalCenter

                text: txt
                font.pixelSize: Theme.componentFontSize
                color: "white"
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (idx === 1) screenBarcodeReader.loadScreen()
                    else if (idx === 2) screenBarcodeWriter.loadScreen()
                    else if (idx === 3) screenBarcodeHistory.loadScreen()
                    else if (idx === 4) screenSettings.loadScreen()
                    else if (idx === 5) screenAbout.loadScreen()
                    screensCol.visible = false
                }
            }

            IconSvg {
                width: parent.height * 0.5
                height: parent.height * 0.5
                anchors.right: parent.right
                anchors.rightMargin: Theme.componentMargin
                anchors.verticalCenter: parent.verticalCenter
                color: "white"
                source: src
            }
        }
    }
}
