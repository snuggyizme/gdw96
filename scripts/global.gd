extends Node

enum PauseType { RUNNING, PAUSED, PAUSED_START_LVL }

var pause: PauseType = PauseType.RUNNING
var targetMapTransfer: PackedScene
