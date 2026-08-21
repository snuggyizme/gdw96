extends Node

enum PauseType { RUNNING, PAUSED, PAUSED_START_LVL, PAUSED_FINISHED }

var pause: PauseType = PauseType.RUNNING
var targetMapTransfer: PackedScene
var volume: float = 85.0
