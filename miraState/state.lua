local M = {}
local state_info = require("miraState.state_info")
local unused_state = 99999

function M.new()
	local instance = {}

	instance.info = state_info.new()
	instance.child_state = nil
	instance.prev_state = 0
	instance.state = 0

	function instance.set_state(state, loop)
		instance.prev_state = state
		instance.state = state
		instance.info.reset()

		if loop then
			instance.info.add_flag(instance.info.loop)
		end

		if not (instance.child_state == nil) then
			instance.child_state.reset()
		end
	end

	function instance.term()
		instance.set_state(unusedState, falsefactory)
	end

	function instance.is_term()
		return instance.is_state(unusedState)
	end

	function instance.get_state()
		return instance.state;
	end

	function instance.is_state(state)
		return (instance.state == state)
	end

	function instance.prev(loop)
		instance.set_state(instance.get_state() - 1, loop)
	end

	function instance.next(loop)
		instance.set_state(instance.get_state() + 1, loop)
	end

	function instance.get_child()
		if instance.child_state == nil then
			instance.child_state = M.new()
		end
		return instance.child_state
	end

	function instance.update(dt)
		if instance.prev_state == instance.state then
			instance.info.update(dt)
			if instance.child_state ~= nil then
				instance.child_state.update(dt)
			end
		end

		instance.prev_state = instance.state

	end

	function instance.is_on_enter()
		return instance.info.one_time_flag(instance.info.on_enter)
	end

	function instance.is_loop()
		if instance.child_state ~= nil then
			return instance.child_state.is_loop() or instance.info.one_time_flag(instance.info.loop)
		end

		return instance.info.one_time_flag(instance.info.loop)
	end

	function instance.reset()
		instance.prev_state = 0
		instance.state = 0
		if instance.child_state ~= nil then
			instance.child_state.reset()
		end
	end

	function instance.wait_time(duration)
		return (instance.info.time > duration)
	end

	return instance
end

return M