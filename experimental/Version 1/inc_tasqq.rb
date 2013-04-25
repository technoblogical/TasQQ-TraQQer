# File: inc_tasqq.rb
$employee_id = 1

class People

	def initialize ( last_name, first_name )
		@last_name = last_name
		@first_name = first_name
		@employee_id = $employee_id
		#$employee_id = $employee_id+1
	end

	def last_name
		@last_name
	end

	def first_name
		@first_name
	end

	def employee_id
		@employee_id.to_i
	end
end

#class Tasks
#end

#class Inventory
#end
