extends Control


func _ready():
	$Panel/Back.grab_focus()


func _on_Button_pressed():
	get_tree().change_scene("res://Scenes/Menu.tscn")
