# mira.state.
hierarchical state machine.

For more info, see substate-sample.script.

# How to Start

Add https://github.com/stepism/defold-mira-substate/archive/master.zip as a dependency in your game.project file.
Fetch library using the main menu: Project -> Fetch Libraries.
Enable the module adding local mira_state = require("miraState.state") at the beginning of your script.



# USAGE
```
local mira_state = require("miraState.state")

-- state for update()
local state_idle = 0
local state_main = 1
local state_sub = 2

-- state for sub_update()
local sub_state_idle = 0
local sub_state_wait = 1

function init(self)
	self.state = mira_state.new()
end

function update(self, dt)

	local state = self.state.get_state()

	if state == state_idle then
		if self.state.is_on_enter() then
			print("update state_idle is_on_enter")
			self.state.next(true)
		end

	elseif state == state_main then		
		if self.state.is_on_enter() then
			print("update state_main is_on_enter")
			self.state.next(true)
		end

	elseif state == state_sub then
		if sub_update(self.state.get_child()) then
			self.state.set_state(state_idle, true)
		end
	end

	self.state.update(dt)
end

function sub_update(sub_state)

	local state = sub_state.get_state()

	if state == sub_state_idle then
		if sub_state.is_on_enter() then
			print("sub_update sub_state_idle is_on_enter")
			sub_state.next(true)
		end

	elseif state == sub_state_wait then
		print("sub_update sub_state_wait waiting...")

		if sub_state.wait_time(2.0) then
			print("sub_update sub_state_wait end")
			-- exit sub_update
			return true
		end
	end

	-- loop sub_update
	return false
end


```

# Operation
https://youtu.be/6XsiNU3rBf0
