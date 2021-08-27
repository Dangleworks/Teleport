zones = {}
aliases = {}
function onCreate(is_world_create)
	zones = server.getZones("type=teleport")
	for i,e in ipairs(zones) do
		for ti=2,#e.tags,1 do
			aliases[e.tags[ti]] = i
		end
	end
end

function onCustomCommand(full_message, user_peer_id, is_admin, is_auth, command, ...)
	args = {...}
	command = string.lower(command)
	if (command == "?tp") then
		dest = aliases[args[1]]
		if dest ~= nil then
			server.setPlayerPos(user_peer_id, zones[dest].transform)
			server.setPlayerPos(user_peer_id, zones[dest].transform)
		end
	end

end
