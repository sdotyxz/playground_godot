class_name UpgradeMatch
extends Match3Effector

func process(match3_grid : Match3Grid, match_array):
	# log create update match effect
	print("create update match effect")

	var upgrade_num = 0

	if match_array.size() == 3:
		upgrade_num = 1
	elif match_array.size() == 4:
		upgrade_num = 2
	elif match_array.size() >= 5:
		upgrade_num = 3

	# pick a dot in match_array to upgrade, dot matched == true
	for match_grid in match_array:

		# get the dot
		var dot = match3_grid.get_dot_at(match_grid.x, match_grid.y)
		if dot.matched == false:
			continue
		# upgrade the dot
		dot.upgrade()
		# log upgrade
		print("upgrade dot at: ", match_grid)
		upgrade_num -= 1
		if upgrade_num <= 0:
			break
	pass
