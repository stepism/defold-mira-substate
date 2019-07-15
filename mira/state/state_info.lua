local M = {}

function M.new()
	local instance = {}

	instance.on_enter = bit.lshift(1, 0)
	instance.loop = bit.lshift(1, 1)

	instance.flag = instance.on_enter
	instance.time = 0

	function instance.has_flag(flag)
		return (bit.band(instance.flag, flag) ~= 0)
	end

	function instance.add_flag(flag)
		instance.flag = bit.bor(instance.flag, flag)
	end

	function instance.del_flag(flag)
		instance.flag = bit.band(instance.flag, bit.bnot(flag))
	end

	function instance.del_flag_all()
		instance.flag = 0
	end

	function instance.set_flag(flag, b)
		if b then
			instance.add_flag(flag)
		else
			instance.del_flag(flag)
		end
	end

	function instance.one_time_flag(flag)
		local temp = instance.has_flag(flag)
		instance.del_flag(flag)
		return temp
	end

	function instance.update(dt)
		--instance.del_flag_all()
		instance.time = instance.time + dt
	end

	function instance.reset()
		instance.add_flag(instance.on_enter)
		instance.time = 0
	end
	return instance

end

return M