# File: tasqq.rb

require "./inc_tasqq.rb"
require "test/unit"

class TestTasQQTraQQer < Test::Unit::TestCase
	def test_01_record_employee_data
		robert=People.new( "Johnson", "Robert" )
		assert_equal(robert.last_name, "Johnson" )
		assert_equal(robert.first_name, "Robert" )
	end	

	def test_02_test_employee_number
		robert=People.new( "Johnson", "Robert" )
		assert_equal(robert.employee_id, 1 )
	end
end
