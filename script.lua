zones = {}
aliases = {}
tpq = {}

function onCreate(is_world_create)
	zones = server.getZones("type=teleport")
	for i,e in ipairs(zones) do
		for ti=2,#e.tags,1 do
			aliases[e.tags[ti]] = i
		end
	end
end

function onCustomCommand(full_message, user_peer_id, is_admin, is_auth, command, ...)
	local args = {...}
	command = string.lower(command)
	if (command == "?tp") then
		if args[1] == nil then
			server.announce("[TP]", "Destination required", user_peer_id)
			return
		end
		local dest = aliases[args[1]]
		if dest == nil then
			server.announce("[TP]", "Invalid destination", user_peer_id)
			return
		end
		
		server.setPlayerPos(user_peer_id, zones[dest].transform)
		tpq[user_peer_id] = {time=server.getTimeMillisec(), dest=zones[dest].transform}
	end
end


function onTick(ticks)
	ctime = server.getTimeMillisec()
	for pid, obj in pairs(tpq) do
		if ctime - obj.time >= 100 then
			server.setPlayerPos(pid, obj.dest)
			tpq[pid] = nil
		end
	end
end