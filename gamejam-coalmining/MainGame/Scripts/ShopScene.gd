extends Node2D

signal shop

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	$ShopCamera.make_current()

func _process(delta):
	#Disable button if you reach the max
	if GlobalVars.boughtSpeed == 5 || GlobalVars.coinsTotal - 10 < 0:
		$ShopUI/BuyItem1.disabled = true
	if GlobalVars.boughtLight == 5 || GlobalVars.coinsTotal - 15 < 0:
		$ShopUI/BuyItem2.disabled = true
	if GlobalVars.boughtMining == 5 || GlobalVars.coinsTotal - 20 < 0:
		$ShopUI/BuyItem3.disabled = true
	
	$Money/Coins/Label.text = str(GlobalVars.coinsTotal)
#Speed
func _on_buy_item_one() -> void:
	print("bought item 1")
	if GlobalVars.coinsTotal - 10 >= 0:
		GlobalVars.coinsTotal -= 10
		GlobalVars.addedSpeed += 5 
		GlobalVars.boughtSpeed += 1
		$ShopUI/BuyItem1.disabled = true

#Light
func _on_buy_item_two() -> void:
	print("bought item 2")
	if GlobalVars.coinsTotal - 15 >= 0:
		GlobalVars.coinsTotal -= 15
		GlobalVars.addedLight += 0.2 
		GlobalVars.boughtLight += 1
		$ShopUI/BuyItem2.disabled = true

#Mine
func _on_buy_item_three() -> void:
	print("bought item 3")
	if GlobalVars.coinsTotal - 20 >= 0:
		GlobalVars.coinsTotal -= 20
		GlobalVars.addedMining += 1
		GlobalVars.boughtMining += 1
		$ShopUI/BuyItem3.disabled = true

func _on_shop_player_near_shop() -> void:
	$ShopUI.visible = true
	shop.emit(true)

func _on_close_pressed() -> void:
	#make player stop moving
	$ShopUI.visible = false
	shop.emit(false)
