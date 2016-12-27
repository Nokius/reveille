import QtQuick 2.0
import Sailfish.Silica 1.0


Page
{
    id: page

    Component.onCompleted: categories.update()

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
                title: "Reveille - Categories"
            }

            Repeater
            {
                id: categoryview
                model: categories
                delegate: BackgroundItem
                {
                    width: column.width
                    height: Theme.itemSizeMedium
                    Label
                    {
                        x: Theme.paddingMedium
                        text: name
                        font.pixelSize: Theme.fontSizeMedium
                        anchors.verticalCenter: parent.verticalCenter
                        elide: Text.ElideRight
                    }
                    onClicked:
                    {
                        users.update(slug, function()
                        {
                            pageStack.push(Qt.resolvedUrl("Users.qml"), {category: name})
                        })
                    }
                }
            }
        }
    }
}

