extends CanvasLayer

@onready var coin = $ControlCoin/Coin/Label
@onready var reputation = $ControlReputation/Reputation/Label

func _process(_delta):
	coin.text = str(Global.money_counter)
	reputation.text = str(Global.reputation_counter)
