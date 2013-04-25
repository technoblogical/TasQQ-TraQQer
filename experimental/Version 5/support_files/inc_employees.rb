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

  def initialize (name_of_corp)
    total_number_of_employees = 0
    @cluster =[]
    @name_of_file = File.join("support_files", name_of_corp.to_s, "employees.csv")
    CSV.foreach(@name_of_file) do |row|
      total_number_of_employees = total_number_of_employees + 1
      @cluster << Employee.new(*row)
    end
    @total_number_of_employees = total_number_of_employees
    @name_of_corp = name_of_corp
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

  def corp_name
    @name_of_corp
  end

  def save
    #File.open(@name_of_file, "w") do |f|
    #  @cluster.each 
    #end
    """ID: 1     | LN: Williams   | FN: Brian      | PayRate: 14.81
ID: 2     | LN: Owen       | FN: Craig      | PayRate: 14.81
ID: 3     | LN: Song       | FN: River      | PayRate: 22.45
ID: 4     | LN: Jones      | FN: Martha     | PayRate: 16.81
ID: 5     | LN: Mott       | FN: Wilfred    | PayRate: 14.81"""
  @cluster
  end


    
end