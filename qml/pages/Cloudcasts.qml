import QtQuick 2.0
import Sailfish.Silica 1.0


Page
{
    id: page

    property string username

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
                title: username + " - Cloudcasts"
            }

            Repeater
            {
                id: cloudcastview
                model: cloudcasts

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
                        Column
                        {
                            anchors.verticalCenter: parent.verticalCenter
                            Label
                            {
                                text: name
                                font.pixelSize: Theme.fontSizeSmall
                                elide: Text.ElideRight
                            }
                            Label
                            {
                                text: "Length " + audio_length
                                font.pixelSize: Theme.fontSizeSmall
                                elide: Text.ElideRight
                            }
                            Label
                            {
                                text: "Played " + play_count + " times"
                                font.pixelSize: Theme.fontSizeSmall
                                elide: Text.ElideRight
                            }
                        }
                    }
                    onClicked:
                    {
                        Qt.openUrlExternally(url)
                    }
                }
            }
        }
    }
}

