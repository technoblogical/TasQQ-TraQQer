require "./support_files/inc_employer.rb"
require 'csv'

puts "What company"
company_name = gets.chomp
user_choice = "Hey, look! I'm declaring a variable for later use."
this_one=Employer.new(company_name)
	puts """Please make a choice from the numbers below
0 || Print number of employees
1 || Print number of tasks
2 || Print out employee data
3 || Print out task data
4 || Add an employee
5 || Start a task (Clock in if needed!)
6 || End a task
7 || Clock out an employee (End tasks if needed!)
8 || Show an employees hours (Requires employee ID!)
9 || Show earnings (So you can write the checks!)
x || Exit the program
"""
until user_choice == "x"
	user_choice = gets.chomp
	case user_choice
	when "0"
		name = this_one.name
		employees = this_one.number_of_employees.to_s
		puts name+" has "+employees+" employees."+"\n\n"
	when "1"
		name = this_one.name
		tasks = this_one.number_of_tasks.to_s
		puts name +" has "+tasks+" tasks."+"\n\n"
		puts "\nnext operation?"
	when "2"
		puts this_one.employees_printout
		puts "\nnext operation?"
	when "3"
		puts this_one.tasks_printout
		puts "\nnext operation?"
	when "4"
		puts "Employee Last Name?"
		l_n = gets.chomp
		puts "Employees First Name?"
		f_n = gets.chomp
		puts "Pay Rate? (Format of 'xx.xx')"
		p_r = gets.chomp
		this_one.add_employees(l_n,f_n,p_r)
		this_one.save
		puts "next operation?"
	when "5"
		puts "Employee ID?"
		e_id = gets.chomp
		puts "Please Describe the task."
		desc = gets.chomp
		this_one.start_task(e_id,desc)
		this_one.save
		puts "next operation?"
	when "6"
		puts "Employee ID?"
		e_id = gets.chomp
		this_one.end_task(e_id)
		this_one.save
		puts "next operation?"
	when "7"
		puts "Employee ID?"
		e_id = gets.chomp
		this_one.clock_out(e_id)
		this_one.save
		puts "next operation?"
	when "8"
		puts "Employee ID?"
		e_id = gets.chomp
		puts this_one.hours (e_id)
		puts "next operation?"
	when "9"
		puts this_one.payroll
		puts "next operation?"
	when "x"
		break
	else
			puts """Please make a choice from the numbers below
0 || Print number of employees
1 || Print number of tasks
2 || Print out employee data
3 || Print out task data
4 || Add an employee
5 || Start a task (Clock in if needed!)
6 || End a task
7 || Clock out an employee (End tasks if needed!)
8 || Show an employees hours (Requires employee ID!)
9 || Show earnings (So you can write the checks!)
x || Exit the program"""
	end
end