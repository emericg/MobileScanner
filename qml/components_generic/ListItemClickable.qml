import QtQuick
import QtQuick.Layouts
import QtQuick.Templates as T
import QtQuick.Controls.impl
import QtQuick.Controls.Material
import QtQuick.Controls.Material.impl

import ThemeEngine

T.ItemDelegate {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight,
                             implicitContentHeight + topPadding + bottomPadding)

    padding: Theme.componentMargin
    spacing: Theme.componentMargin
    verticalPadding: 0

    property string iconSource
    property string iconColor: Theme.colorIcon
    property int iconSize: 32

    property string textColor: Theme.colorText
    property int textSize: Theme.fontSizeContent

    property string indicatorSource
    property string indicatorColor: Theme.colorIcon
    property int indicatorSize: 20

    ////////////////

    background: Rectangle {
        implicitHeight: Theme.componentHeightXL

        color: control.highlighted ? Theme.colorForeground : Theme.colorBackground

        RippleThemed {
            width: parent.width
            height: parent.height

            clip: visible
            anchor: control
            pressed: control.pressed
            active: enabled && (control.down || control.visualFocus || control.hovered)
            color: Qt.rgba(Theme.colorForeground.r, Theme.colorForeground.g, Theme.colorForeground.b, 0.1)
        }
    }

    ////////////////

    contentItem: RowLayout {
        anchors.left: parent.left
        anchors.leftMargin: screenPaddingLeft + Theme.componentMargin
        anchors.right: parent.right
        anchors.rightMargin: screenPaddingRight + Theme.componentMargin

        opacity: control.enabled ? 1 : 0.4
        spacing: 0

        Item {
            Layout.preferredWidth: appHeader.headerPosition - parent.anchors.leftMargin
            Layout.preferredHeight: Theme.componentHeightXL
            Layout.alignment: Qt.AlignTop

            IconSvg {
                anchors.left: parent.left
                anchors.leftMargin: (32 - control.iconSize) / 2
                anchors.verticalCenter: parent.verticalCenter
                //anchors.verticalCenterOffset: (control.height !== Theme.componentHeightXL) ? -(Theme.componentMargin / 2) : 0

                width: control.iconSize
                height: control.iconSize
                color: control.iconColor
                source: control.iconSource
            }
        }

        Text {
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignVCenter

            text: control.text
            color: control.textColor
            linkColor: control.iconColor
            wrapMode: Text.WordWrap
            font.pixelSize: control.textSize
        }

        IconSvg {
            Layout.preferredWidth: control.indicatorSize
            Layout.preferredHeight: control.indicatorSize
            Layout.alignment: Qt.AlignVCenter
            color: control.indicatorColor
            source: control.indicatorSource
        }
    }

    ////////////////
}
