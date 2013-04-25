# file: test-TasQQ-Traqqer.rb 

require "./support_files/inc_employees.rb"
require "test/unit"
require 'csv'

class Test_TasQQ_TraQQer < Test::Unit::TestCase
	def test_01_make_sure_the_employees_print_out
		q = """ID: 1     | LN: Williams   | FN: Brian      | PayRate: 14.81
ID: 2     | LN: Owen       | FN: Craig      | PayRate: 14.81
ID: 3     | LN: Song       | FN: River      | PayRate: 22.45"""
		this_one = Employer.new ( "dummy" )
		assert_equal(this_one.printout, q)
	end

	def test_02_check_for_total_number_of_employees
		this_one = Employer.new ( "dummy" )
		assert_equal(this_one.total_number_of_employees, 3)

	end

	def test_03_make_sure_employees_can_be_added
				q = """ID: 1     | LN: Williams   | FN: Brian      | PayRate: 14.81
ID: 2     | LN: Owen       | FN: Craig      | PayRate: 14.81
ID: 3     | LN: Song       | FN: River      | PayRate: 22.45
ID: 4     | LN: Jones      | FN: Martha     | PayRate: 16.81
ID: 5     | LN: Mott       | FN: Wilfred    | PayRate: 14.81"""
		this_one = Employer.new ( "dummy" )
		this_one.new_hire("Jones", "Martha", 16.81)
		this_one.new_hire("Mott", "Wilfred", 14.81)
		assert_equal(this_one.printout, q)		
	end

	def test_04_checking_the_name_of_the_corporation_is_saved
		this_one = Employer.new ( "dummy" )
		assert_equal(this_one.corp_name, "dummy")
	end

	def test_05_write_to_the_file
				q = """ID: 1     | LN: Williams   | FN: Brian      | PayRate: 14.81
ID: 2     | LN: Owen       | FN: Craig      | PayRate: 14.81
ID: 3     | LN: Song       | FN: River      | PayRate: 22.45
ID: 4     | LN: Jones      | FN: Martha     | PayRate: 16.81
ID: 5     | LN: Mott       | FN: Wilfred    | PayRate: 14.81"""
		this_one = Employer.new ("dummy")
		assert_equal(this_one.save, q)
	end

end