import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import QtQuick.Timeline 1.0

import Constant 1.0



Button{
	id:liquidButton

	property int batteryState: 1
	property real batteryLevel: 100

	text:"شروع"

	width: parent.width * 1.2
	height: parent.width * 1.2
	anchors.bottom: parent.bottom
	anchors.horizontalCenter: parent.horizontalCenter
	font.pixelSize: Constant.h3FontSize
	contentItem: Text {
		anchors.centerIn: parent
		anchors.verticalCenterOffset: 15
		text: liquidButton.text
		visible: true
		horizontalAlignment: Qt.AlignHCenter
		verticalAlignment: Qt.AlignVCenter
		color: Constant.whiteColor
		font.bold: true
		font.pixelSize: liquidButton.font.pixelSize
		font.letterSpacing: liquidButton.font.letterSpacing
	}

	background: Item
	{
		id: batteryBlob
		anchors.fill:parent

		state: "balanced"


		Rectangle {
			id: rectangle
			anchors.fill: parent
			visible: false
			color: "#595959"
		}

		Image {
			id: background
			visible: false
			source: "qrc:/img/background.png"
			anchors.fill: parent
			fillMode: Image.Tile
		}

		Item {
			id: itemGradient
			width: parent.width * 0.7
			height: parent.height * 0.7
			visible: false

			Rectangle {
				id: rectGradient
				visible: true
				border.color: "#11998e"
				border.width: 0
				anchors.fill: parent
				rotation: -blob.rotation
				gradient: Gradient {
					GradientStop {
						position: 0
						color: Constant.gold
					}
					GradientStop {
						position: 1
						color: Constant.orange
					}
				}
			}
		}

		ShaderEffectSource {
			id: gradientBlob
			sourceItem: itemGradient
		}

		Item {
			anchors.fill: parent

			layer.effect: InnerShadow {
				id: innerShadow
				opacity: 0.036
				visible: true
				color: "#aae2a1"
				spread: 0.5
				horizontalOffset: 0
				fast: false
			}
			layer.enabled: true

			Blob {
				id: blob
				x: 100
				visible: true
				anchors.fill: parent
				animOffset: 0
				state: "battery"
				size: liquidButton.batteryLevel * 0.005 + 0.5
				speed: -1
				anchors.rightMargin: 0
				anchors.leftMargin: 0
				anchors.topMargin: 0
				anchors.bottomMargin: 0
				texture: gradientBlob
				ringCount: 4
				ringMinDist: 0.
				ringMaxDist: 100.
				ringWidth: 1.5
				easing: 1.
			}
		}

		Timeline {
			id: timeline
			animations: [
				TimelineAnimation {
					id: cons
					loops: -1
					running: false
					duration: 500
					to: 10
					from: 0
				},
				TimelineAnimation {
					id: recu
					loops: -1
					running: false
					duration: 500
					to: 0
					from: 10
				}
			]
			enabled: true
			startFrame: 0
			endFrame: 10

			KeyframeGroup {
				target: blob
				property: "animOffset"
				Keyframe {
					frame: 0
					value: 0
				}

				Keyframe {
					frame: 10
					value: 1
				}
			}

			KeyframeGroup {
				target: blob
				property: "x"
				Keyframe {
					value: 0
					frame: 0
				}

				Keyframe {
					value: 0
					frame: 100
				}
			}
		}
		states: [
			State {
				name: "balanced"
				when: liquidButton.batteryState === 0
			},
			State {
				name: "recuperation"
				when: liquidButton.batteryState === 1

				PropertyChanges {
					target: timeline
					enabled: true
				}

				PropertyChanges {
					target: cons
				}

				PropertyChanges {
					target: blob
					animOffset: 0.25
				}

				PropertyChanges {
					target: recu
					running: true
				}
			},
			State {
				name: "consumption"
				when: liquidButton.batteryState === 2

				PropertyChanges {
					target: timeline
					enabled: true
				}

				PropertyChanges {
					target: cons
					running: true
				}

				PropertyChanges {
					target: recu
				}
			}
		]
	}
}
