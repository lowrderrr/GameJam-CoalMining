extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	$ShopCamera.make_current()

func _on_buy_item_one() -> void:
	pass # Replace with function body.
	print("bought item 1")
	$ShopUI/BuyItem1.disabled = true

func _on_buy_item_two() -> void:
	pass # Replace with function body.
	print("bought item 2")
	$ShopUI/BuyItem2.disabled = true

func _on_buy_item_three() -> void:
	pass # Replace with function body.
	print("bought item 3")
	$ShopUI/BuyItem3.disabled = true

func _on_shop_player_near_shop() -> void:
	$ShopUI.visible = true

func _on_close_pressed() -> void:
	#make player stop moving
	$ShopUI.visible = false
