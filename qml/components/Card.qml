import QtQuick 2.15
import QtGraphicalEffects 1.15
import QtQuick.Layouts 1.15

import Constant 1.0

Rectangle{
    id:root
    radius:20
    layer.enabled: true
    layer.effect: DropShadow {
        transparentBorder: true
        horizontalOffset: 0
        verticalOffset: 0
        color: Constant.shadowColor
        samples: 8
        radius: 8
        spread: 0.0
    }
}
