
# Node customizado para Area2d
# Serve para tornar a ação de um hit em um corpo menos direta, através dos signals
# As duas instancias se comunicam que houve hit, ativando ambos os signals
# ...o corpo interessado apenas incorpora o signal.

@tool

extends Area2D
class_name CustomArea2D

#mediators
signal trigger
signal release
#implements
const _Utils := preload("uid://1d5fudhdyhq2")
const _Config := preload("uid://c0ftn5ke7viq")

var _config  := preload("uid://c0ftn5ke7viq")
var _config_groups := _Config.groups
var _label_groups := _Config.groups.duplicate(true)

@export_group("Hit Group")
@export var group : String  :    ##Matching hit group. The CustomArea will only interact with and emit signals to areas in the same selected Group or to those that share one or more groups from the Group Set.      Note: The selected Group and the Group Set do not conflict and can be used simultaneously—you can choose the approach that best fits your organization.        Note: For a minor optimization, you can assign a commonly used Group. When Groups match, the Group Set check is skipped.

	set(val):
		group = val.strip_edges()
		_set_name()



@export_tool_button("Add to Group Set")
var _inspector_btn_add_group_to_set = _inspector_btn_add_group_to_set_activate

@export var group_set : Array[String] :
	set(val):
		group_set = val
		_set_name()
		_mark_selected_group()
		notify_property_list_changed()
		

func _trigger():
	trigger.emit()
	
	
func _release():
	release.emit()



#CORE
func _init() -> void:
	#CONECTAR SIGNALS PADRÕES AO INICIAR NODE
	area_entered.connect( _on_area_entered )
	area_exited.connect( _on_area_exited )
func _on_area_entered(area: Area2D) -> void:
	if area is CustomArea2D:
		var b_same_group : bool= self.group == area.group
		
		if b_same_group or _Utils.array_has_any( self.group_set, area.group_set ):
			area.trigger.emit()


func _on_area_exited(area: Area2D) -> void:
	if area is CustomArea2D:
		var b_same_group : bool= self.group == area.group
		
		if b_same_group or _Utils.array_has_any( self.group_set, area.group_set ):
			area.release.emit()


#INSPECTOR
func _inspector_btn_add_group_to_set_activate() -> void:
	#ADD TO SET
	if (not group_set.has( group )) and _config_groups.has( group ):
		group_set.append( group )
		group = ""
		_mark_selected_group()
		
		notify_property_list_changed()
		
		
func _validate_property(property: Dictionary) -> void:
	if property.name ==  "group":
		property.hint = PROPERTY_HINT_ENUM
		property.hint_string = ",".join( _label_groups ) 


#CALLS
func _set_name():
	##TODO - Melhorar sistemas de nomes
		##SE tiver mais valor no group
		if group_set.is_empty():
			if not group.is_empty():
				self.name = str( group ) + "_CustomArea2D"
			else:
				self.name = "CustomArea2D"
		else:
			var initials : String = ",".join( _Utils.array_abbreviate_names( group_set ) )
			
			name = "set(" + initials + ")_CustomArea2d"
			
			
			
func _mark_selected_group() :
	
	for index in _config_groups.size():
		var label : String = _config_groups[index]
		if group_set.has(label):
			label = "            " + label
		
		_label_groups[index] = label
		
