extends Control


func _ready():
	$VBoxContainer/ModeKills.grab_focus()


func _on_Button_pressed():
	get_tree().change_scene("res://Scenes/WORDL.tscn")
	node.hide()
	


func _on_Button2_pressed():
	get_tree().change_scene("res://Scenes/WORDL.tscn")
	node.hide()


func _on_Back_pressed():
	get_tree().change_scene("res://Scenes/Menu.tscn")
