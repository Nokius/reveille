TARGET = harbour-reveille

CONFIG += sailfishapp

SOURCES += src/reveille.cpp

OTHER_FILES += \
    rpm/harbour-reveille.spec \
    harbour-reveille.desktop

SAILFISHAPP_ICONS = 86x86 108x108 128x128 256x256

DISTFILES += \
    qml/cover/CoverPage.qml \
    qml/pages/MainPage.qml \
    qml/harbour-reveille.qml \
    qml/pages/Users.qml \
    qml/components/Messagebox.qml \
    qml/pages/Cloudcasts.qml
