class Employee
  attr_accessor :year, :make, :model, :length
  
  def initialize(employee_id, last_name, first_name, pay_rate)
    @employee_id = employee_id
    @first_name = first_name
    @last_name = last_name
    @pay_rate = pay_rate.to_s
  end
  
  def to_s
    "ID: #{@employee_id.ljust(5)} | LN: #{@last_name.ljust(10)} | FN: #{@first_name.ljust(10)} | PayRate: #{@pay_rate.ljust(5)}"
  end
end

require 'csv'

class Employer

  def initialize (name_or_corp)
    total_number_of_employees = 0
    @cluster =[]
    CSV.foreach("support_files/#{name_or_corp}.csv") do |row|
      total_number_of_employees = total_number_of_employees + 1
      @cluster << Employee.new(*row)
    end
    @total_number_of_employees = total_number_of_employees
  end

  def printout
    printout = @cluster.join("\n")
    printout
  end

  def total_number_of_employees
    @total_number_of_employees
  end

  def new_hire(last_name, first_name, pay_rate)
    @total_number_of_employees = @total_number_of_employees + 1
    @cluster << Employee.new(@total_number_of_employees.to_s, last_name, first_name, pay_rate)
  end


    
end