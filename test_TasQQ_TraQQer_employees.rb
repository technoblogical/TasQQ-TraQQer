# file: test-TasQQ-Traqqer.rb 

require "./support_files/inc_employer.rb"
require "test/unit"
require 'csv'


class Test_TasQQ_TraQQer < Test::Unit::TestCase

	def test_001_make_sure_the_company_name_is_recorded
		this_one = Employer.new( "dummy" )
		assert_equal(this_one.name,"dummy")
		assert_equal(2, 2)
	end

	def test_002_make_sure_the_file_paths_are_correct
		this_one = Employer.new("dummy")
		assert_equal(this_one.employees_file_path,"support_files/dummy/employees.csv")
		assert_equal(this_one.tasks_file_path, "support_files/dummy/tasks.csv")
	end

	def test_003_checking_for_employees
		this_one = Employer.new("dummy")
		assert_equal(this_one.employees_raw_data,[["1", "Williams", "Brian", "14.81"," 3","n","1350497146","241"],
												  ["2", "Owen", "Craig", "14.81"," 2 4","y","1350642741","272"],
												  ["3", "Song", "River", "22.45"," 1","n","1350497146","256"]])
	end

	def test_004_checking_for_tasks
		this_one = Employer.new("dummy")
		assert_equal(this_one.tasks_raw_data,[["1","3","1350497146","1350497402","Sweeping"],
											  ["2","2","1350497146","1350497418","Washing Trucks"],
											  ["3","1","1350497146","1350497387","Counting Inventory"],
											  ["4", "2", "1350497146", " ", "Washing Windows"]])
	end

	def test_005_checking_for_number_of_employees_and_tasks
		this_one = Employer.new("dummy")
		assert_equal(this_one.number_of_employees,3)
		assert_equal(this_one.number_of_tasks,4)
	end

	def test_006_making_a_printout_of_all_employees_and_tasks
		expected_employees_result="""Employees ID:1    Last Name:Williams            First Name:Brian               Pay Rate:14.81 
Employees ID:2    Last Name:Owen                First Name:Craig               Pay Rate:14.81 
Employees ID:3    Last Name:Song                First Name:River               Pay Rate:22.45 
"""
		expected_tasks_result="""Tasks ID:1    Employees ID:3    Description:Sweeping                                          
Started:Wed Oct 17 13:05:46 2012                Stopped:Wed Oct 17 13:10:02 2012                

Tasks ID:2    Employees ID:2    Description:Washing Trucks                                    
Started:Wed Oct 17 13:05:46 2012                Stopped:Wed Oct 17 13:10:18 2012                

Tasks ID:3    Employees ID:1    Description:Counting Inventory                                
Started:Wed Oct 17 13:05:46 2012                Stopped:Wed Oct 17 13:09:47 2012                

Tasks ID:4    Employees ID:2    Description:Washing Windows                                   
Started:Wed Oct 17 13:05:46 2012                Stopped:                                

"""
		this_one = Employer.new("dummy")
		assert_equal(this_one.employees_printout,expected_employees_result)
		assert_equal(this_one.tasks_printout,expected_tasks_result)
	end

	def test_007_add_an_employees
		this_one = Employer.new("dummy")
		this_one.add_employees("Smith","Martha",15.81)
		assert_equal(this_one.employees_raw_data, [["1","Williams", "Brian","14.81"," 3","n","1350497146","241"],
												   ["2","Owen","Craig","14.81"," 2 4","y","1350642741","272"],
												   ["3", "Song","River", "22.45"," 1","n","1350497146","256"],
												   ["4","Smith","Martha","15.81"," ","n"," ","0"]])
	end

	def test_008_save_the_employees_and_tasks_to_the_files
		this_one = Employer.new("dummy")
		this_one.add_employees("Smith","Martha",15.81)
		this_one.save

		this_one = Employer.new("dummy")
		this_one.add_employees("Noble","Donna",14.81)
		this_one.save
		this_one = Employer.new("dummy")
		assert_equal(this_one.employees_raw_data, [["1","Williams", "Brian","14.81"," 3","n","1350497146","241"],
												   ["2","Owen","Craig","14.81"," 2 4","y","1350642741","272"],
												   ["3", "Song","River", "22.45"," 1","n","1350497146","256"],
												   ["4","Smith","Martha","15.81"," ","n"," ","0"],
												   ["5", "Noble","Donna", "14.81"," ","n"," ","0"]])
	end

	def test_009_start_a_task
		this_one = Employer.new("dummy")
		this_one.start_task(1,"Working on code")
		this_one.save

		that_one = Employer.new("dummy")
		expected_time = Time.now.to_i.to_s
		assert_equal(that_one.tasks_raw_data,[["1","3","1350497146","1350497402","Sweeping"],
											  ["2","2","1350497146","1350497418","Washing Trucks"],
											  ["3","1","1350497146","1350497387","Counting Inventory"],
											  ["4", "2", "1350497146", " ", "Washing Windows"],
											  ["5", "1", expected_time , " ", "Working on code"]])
		assert_equal(that_one.employees_raw_data,[["1","Williams", "Brian","14.81"," 3 5","y",expected_time,"241"],
						 ["2","Owen","Craig","14.81"," 2 4","y","1350642741","272"],
						 ["3", "Song","River", "22.45"," 1","n","1350497146","256"],
						 ["4","Smith","Martha","15.81"," ","n"," ","0"],
						 ["5", "Noble","Donna", "14.81"," ","n"," ","0"]])

	end

	def test_010_end_a_task
		this_one = Employer.new("dummy")
		this_one.end_task(2)
		this_one.save

		that_one = Employer.new("dummy")
		expected_time = Time.now.to_i.to_s
		assert_equal(that_one.tasks_raw_data,[["1","3","1350497146","1350497402","Sweeping"],
											 ["2","2","1350497146","1350497418","Washing Trucks"],
											 ["3","1","1350497146","1350497387","Counting Inventory"],
											 ["4", "2", "1350497146", expected_time, "Washing Windows"],
											 ["5", "1", expected_time , " ", "Working on code"]])
	end

	def test_011_clock_people_out
		this_one=Employer.new("dummy")
		expected_time = Time.now.to_i
		expected_total_time = expected_time - 1350642741 + 272
		this_one.clock_out(2)
		this_one.save

		that_one = Employer.new("dummy")
		assert_equal(that_one.employees_raw_data,[["1","Williams", "Brian","14.81"," 3 5","y",expected_time.to_s,"241"],
						 ["2","Owen","Craig","14.81"," 2 4","n","1350642741",expected_total_time.to_s],
						 ["3", "Song","River", "22.45"," 1","n","1350497146","256"],
						 ["4","Smith","Martha","15.81"," ","n"," ","0"],
						 ["5", "Noble","Donna", "14.81"," ","n"," ","0"]])
		assert_equal(that_one.tasks_raw_data,[["1","3","1350497146","1350497402","Sweeping"],
											 ["2","2","1350497146","1350497418","Washing Trucks"],
											 ["3","1","1350497146","1350497387","Counting Inventory"],
											 ["4", "2", "1350497146", expected_time.to_s, "Washing Windows"],
											 ["5", "1", expected_time.to_s, " ", "Working on code"]])
	end

	def test_012_check_for_current_total_hours
		this_one=Employer.new("dummy")
		expected_time = Time.now.to_i
		expected_total_time = expected_time - 1350642741 + 272
		expected_total_time = expected_total_time.to_f/3600
		assert_equal(this_one.hours("1"),"0.06694444444444445")
		assert_equal(this_one.hours("2"),expected_total_time.to_s)
		assert_equal(this_one.hours("3"),"0.07111111111111111")
	end

	def test_013_print_out_how_much_you_owe_everybody
		this_one =Employer.new("dummy")
		expected_time = Time.now.to_i
		expected_total_time = expected_time - 1350642741 + 272
		expected_total_time = expected_total_time.to_f/3600
		expected_total_time = expected_total_time.round(4)
		expected_total_time = expected_total_time*14.81
		expected_total_time = expected_total_time.round(2)
		assert_equal(this_one.payroll,"""Name:Williams, Brian                         
ID:1  Paycheck Amount:0.99

Name:Owen, Craig                             
ID:2  Paycheck Amount:#{expected_total_time.to_s}

Name:Song, River                             
ID:3  Paycheck Amount:1.6

Name:Smith, Martha                           
ID:4  Paycheck Amount:0.0

Name:Noble, Donna                            
ID:5  Paycheck Amount:0.0

""")
	end

	def test_099_reset_files
		#sleep 10
		system "cp support_files/dummy/backup_employees_for_testing.csv support_files/dummy/employees.csv"
		system "cp support_files/dummy/backup_tasks_for_testing.csv support_files/dummy/tasks.csv"
	end

end