class_name TestCSVDataImporter
extends Node

func _ready():
	var csv_data = preload("res://examples/csv-data-importer/test.csv")
	#print all csv data records
	for record in csv_data.records:
		print(record)