import QtQuick 2.0
import Sailfish.Silica 1.0


Page
{
    id: page

    property string category

    SilicaFlickable
    {
        anchors.fill: parent

        contentHeight: column.height

        Column
        {
            id: column

            width: page.width
            spacing: Theme.paddingLarge
            PageHeader
            {
                title: category + " - Users"
            }

            Repeater
            {
                id: usersview
                model: users

                delegate: BackgroundItem
                {
                    width: column.width
                    height: Theme.itemSizeLarge

                    Row
                    {
                        x: Theme.paddingMedium
                        height: parent.height - Theme.paddingSmall
                        spacing: Theme.paddingSmall
                        anchors.verticalCenter: parent.verticalCenter

                        Image
                        {
                            source: pictures.medium
                            width: parent.height
                            height: parent.height
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        Label
                        {

                            text: name
                            font.pixelSize: Theme.fontSizeSmall
                            elide: Text.ElideRight
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }
                    onClicked:
                    {
                        cloudcasts.update(username, function()
                        {
                            pageStack.push(Qt.resolvedUrl("Cloudcasts.qml"), { username: name })
                        })
                    }

                }
            }
        }
    }
}

