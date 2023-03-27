extends Control

func _ready():
	$VBoxContainer/PlayAgain.grab_focus()


func _on_PlayAgain_pressed():
	get_tree().change_scene("res://Scenes/WORDL.tscn")

func _on_Exit_pressed():
	get_tree().change_scene("res://Scenes/Menu.tscn")

