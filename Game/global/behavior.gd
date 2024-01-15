class_name Behavior
extends Node2D

var parent_:Node = null

func init(parent:Node)->Node:
	parent_ = parent
	return self
