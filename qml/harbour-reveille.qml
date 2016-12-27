import QtQuick 2.0
import Sailfish.Silica 1.0
import org.nemomobile.configuration 1.0
import QtQuick.XmlListModel 2.0
import "components"

ApplicationWindow
{
    initialPage: Qt.resolvedUrl("pages/MainPage.qml")
    cover: Qt.resolvedUrl("cover/CoverPage.qml")
    allowedOrientations: Orientation.All
    _defaultPageOrientations: Orientation.All


/***** Lists *****/

    ListModel
    {
        id: categories

        property var allCategories

        function update()
        {
            request("https://api.mixcloud.com/categories/",
            function (o)
            {
                allCategories = JSON.parse(o.responseText)
                logjson(allCategories, "categories.update()")

                clear()

                for (var i=0 ; i<allCategories.data.length ; i++)
                {
                    append( allCategories.data[i] )
                }
            })
        }
    }

    ListModel
    {
        id: users

        property var allusers

        function update(slug, callback)
        {
            request("https://api.mixcloud.com/categories/" + slug + "/users/",
            function (o)
            {
                allusers = JSON.parse(o.responseText)
                logjson(allusers, "users.update()")

                clear()

                for (var i=0 ; i<allusers.data.length ; i++)
                {
                    append( allusers.data[i] )
                }

                if (typeof callback === "function")
                    callback()
            })
        }
    }

    ListModel
    {
        id: cloudcasts

        property var allcloudcasts

        function update(username, callback)
        {
            request("https://api.mixcloud.com/" + username + "/cloudcasts/",
            function (o)
            {
                allcloudcasts = JSON.parse(o.responseText)
                logjson(allcloudcasts, "cloudcasts.update()")

                clear()

                for (var i=0 ; i<allcloudcasts.data.length ; i++)
                {
                    append( allcloudcasts.data[i] )
                }

                if (typeof callback === "function")
                    callback()
            })
        }
    }

/***** Low level *****/

    function request(url, callback)
    {
        bi.start()
        log(url)
        var xhr = new XMLHttpRequest()
        xhr.onreadystatechange = (function(myxhr)
        {
            return function()
            {
                if(myxhr.readyState === 4)
                {
                    bi.stop()
                    log(myxhr.status, "request status")
                    if (myxhr.status < 200 || myxhr.status > 204)
                    {
                        log(myxhr.responseText, "request error")
                        msgbox.showError("Operation failed")
                    }
                    else
                    {
                        if (typeof callback === "function")
                            callback(myxhr)
                    }
                }
            }
        })(xhr)
        xhr.open("GET", url, true)
        xhr.setRequestHeader("Content-type", "application/json")
        xhr.send('')
    }

/***** Global visuals *****/

    BusyIndicator
    {
        id: bi
        running: false
        size: BusyIndicatorSize.Large
        anchors.centerIn: parent
        function start() { running = true }
        function stop() { running = false }
    }

    Messagebox
    {
        id: msgbox
    }

/***** Logging *****/

    ConfigurationValue
    {
        id: verbose
        key: "/apps/harbour-reveille/verbose"
        defaultValue: 1
    }
    ConfigurationValue
    {
        id: verbosejson
        key: "/apps/harbour-reveille/verbosejson"
        defaultValue: 1
    }

    function log(text, desc)
    {
        if (verbose.value && typeof desc !=='undefined')
            console.log(desc + " >>> " + text)
        else if (verbose.value)
            console.log(text)
    }
    function logjson(obj, desc)
    {
        if (verbosejson.value && typeof desc !=='undefined')
            console.log(desc + " >>>")
        if (verbosejson.value)
            console.log(JSON.stringify(obj, null, 4))
    }

}

