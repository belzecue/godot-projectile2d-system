extends CollisionShape2D
class_name Projectile





#CAST STUFF

#export(float) var radius : float = 1.0
#export(int, LAYERS_2D_PHYSICS) var collision_layer
#
#export(int) var max_results : int = 6
#export(float) var margin : float = 0.0
#
#export(bool) var collide_with_bodies = true
#export(bool) var collide_with_areas = false
#
#
#
#
#var _query : Physics2DShapeQueryParameters = null
#var _circle_shape : CircleShape2D = null
#var _excluded : Array = []
#
#
#
#
#func addExclusion(obj) -> void:
#	_excluded.append(obj)
#
#func removeExclusion(obj) -> void:
#	if not _excluded or _excluded.size() <= 0: return
#	var index : int = _excluded.find(obj)
#	removeExclusionIndex(index)
#
#func removeExclusionIndex(index : int) -> void:
#	if not _excluded or _excluded.size() <= 0 or index < 0 or index >= _excluded.size(): return
#	_excluded.remove(index)
#
#
#
#func setCircleShapeRadius(r : float) -> void:
#	if r <= 0.0: return
#	getCircleShape().radius = r
#
#
#func getCircleShape() -> CircleShape2D:
#	if _circle_shape == null:
#		_circle_shape = CircleShape2D.new()
#		_circle_shape.radius = self.radius
#	return _circle_shape
#
#
#func getQuery() -> Physics2DShapeQueryParameters:
#	if not _query:
#		setQuery(createQuerySimple())
#	return _query
#
#func setQuery(query : Physics2DShapeQueryParameters) -> void:
#	_query = query
#
#
#func updateQuery(pos : Vector2, rot : float, r : float = -1.0) -> void:
#	setCircleShapeRadius(r)
#	updateCustomQuery(getQuery(), pos, rot, null)
#
#func updateCustomQuery(query : Physics2DShapeQueryParameters, pos : Vector2, rot : float, shape = null) -> void:
#	if not query: return
#	query.transform = Transform2D(rot, pos)
#	if shape:
#		query.set_shape(shape)
#
#
#
#func createQuerySimple() -> Physics2DShapeQueryParameters:
#	return createQuery(global_position, global_rotation, Vector2.ZERO, getCircleShape(), collision_layer, _excluded, collide_with_bodies, collide_with_areas, margin)
#
#func createQuery(_pos : Vector2, _rot : float, _motion : Vector2, _shape, _collision_layer, _exclude : Array = [], _collide_with_bodies : bool = true, _collide_with_areas : bool = false, _margin : float = 0.0) -> Physics2DShapeQueryParameters:
#	var query := Physics2DShapeQueryParameters.new()
#	query.set_shape(_shape)
#	query.motion = _motion
#	query.collision_layer = _collision_layer
#	query.exclude = _exclude
#	query.collide_with_bodies = _collide_with_bodies
#	query.collide_with_areas = _collide_with_areas
#	query.transform = Transform2D(_rot, _pos)
#	query.margin = _margin
#	return query
#
#
#func getSpaceState() ->  Physics2DDirectSpaceState:
#	return get_world_2d().direct_space_state
#
#
#
#
#func cast(r : float = -1.0) -> Array:
#	updateQuery(global_position, global_rotation, r)
#	return intersectShape(getQuery(), max_results)
#
#func castStatic(r : float = -1.0) -> Array:
#	setCircleShapeRadius(r)
#	return intersectShape(getQuery(), max_results)
#
#func castCustom(_pos : Vector2, _rot : float, _shape, _collision_layer, _exclude : Array = [], _collide_with_bodies : bool = true, _collide_with_areas : bool = false, _margin : float = 0.0, max_results : int = 32) -> Array:
#	var query = createQuery(_pos, _rot, Vector2.ZERO, _shape, _collision_layer, _exclude, _collide_with_bodies, _collide_with_areas, _margin)
#	return intersectShape(query, max_results)
#
#
#static func filterResults(result : Array) -> Array:
#	print("results: ", result)
#	if not result or result.size() <= 0:
#		return []
#	if result.size() == 1:
#		return [result[0].collider]
#
#	var filtered : Array = []
#	for i in range(result.size()):
#		var body = result[i].collider
#		if not body in filtered:
#			filtered.append(body)
#
#	return filtered
#
#static func filterResultsAdv(result : Array) -> Dictionary:
#	if not result or result.size() <= 0:
#		return {}
#
#	var filtered : Dictionary = {}
#	if result.size() == 1:
#		filtered[result[0].collider_id] = {"body" : result[0].collider, "shapes" : [result[0].shape]}
#		return filtered
#
#	for r in result:
#		if filtered.has(r.collider_id):
#			filtered[r.collider_id].shapes.append(r.shape)
#		else:
#			filtered[r.collider_id] = {"body" : r.collider, "shapes" : [r.shape]}
#
#	return filtered
#
#
#func castMotion(query : Physics2DShapeQueryParameters) -> Array:
#	return getSpaceState().cast_motion(query)
#
#
#func getCollisionPoints(query : Physics2DShapeQueryParameters, max_results : int = 32) -> Array:
#	return getSpaceState().collide_shape(query, max_results)
