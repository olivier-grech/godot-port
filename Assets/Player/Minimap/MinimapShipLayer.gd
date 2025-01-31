extends MinimapLayer
class_name MinimapShipLayer

export var ship_icon_scale: Vector2
export var player_ship_icon: Texture
export var trader_ship_icon: Texture
export var pirate_ship_icon: Texture

var timer: Timer
var minimap: Minimap
var player_ships: Array
var trader_ships: Array
var pirate_ships: Array

func _draw():
	if minimap == null:
		return

	for player_ship in player_ships:
		draw_set_transform(player_ship,
			-minimap.get_rotation(),
			ship_icon_scale)
		draw_texture(player_ship_icon,
			player_ship_icon.get_size() * ship_icon_scale / -2)

	# TODO: draw pirate and trader ships

func draw_layer():
	timer = $Timer
	minimap = get_parent() as Minimap

	timer.connect("timeout", self, "get_ships")

func get_ships():
		# get player ship(s)
		# list might contain previous coordinates, so clear it before getting new ones
		player_ships.clear()
		var player_ships_node : Spatial = get_tree().current_scene.get_node("PlayerStart/Ships")
		for player_ship in player_ships_node.get_children():
			if player_ship is Ship:
				player_ships.append(
					minimap.world_to_minimap_position(player_ship.global_transform.origin))

		# get trader ship(s)
		#var trader_ships_node : Spatial = get_tree().current_scene.get_node("Traders")
		#for trader_ship in trader_ships_node.get_children():
		#	if trader_ship is Ship:
		#		trader_ships.append(
		#			minimap.world_to_minimap_position(trader_ship.global_transform.origin))

		# get trader ship(s)
		#var pirate_ships_node : Spatial = get_tree().current_scene.get_node("Traders")
		#for pirate_ship in pirate_ships_node.get_children():
		#	if pirate_ship is Ship:
		#		pirate_ships.append(
		#			minimap.world_to_minimap_position(pirate_ship.global_transform.origin))

		update()
