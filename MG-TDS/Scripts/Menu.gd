extends Control


func _ready():
	$VBoxContainer/StartButton.grab_focus()


func _on_StartButton_pressed():
	get_tree().change_scene("res://Scenes/WORDL.tscn")


func _on_OptionsButton_pressed():
	pass

 
func _on_ExitButton_pressed():
	get_tree().quit()


func _on_ControlsButton_pressed():
	get_tree().change_scene("res://Scenes/Controls.tscn")


func _on_HighscoreButton_pressed():
	pass # Replace with function body.
