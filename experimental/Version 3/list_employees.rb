class Employee_list
  attr_accessor :employee_id, :first_name, :last_name,  :pay_rate
  
  def initialize(employee_id, last_name, first_name, pay_rate)
    @employee_id = employee_id
    @first_name = first_name
    @last_name = last_name
    @pay_rate = pay_rate
  end
  
  def to_s
    "ID: #{@employee_id.ljust(3)}| FN: #{@first_name.ljust(10)} | LN: #{@last_name.ljust(10)} | Pay: #{@pay_rate.to_s.ljust(6)}"
  end

end

require 'csv'

employees = Array.new
CSV.foreach('employees.csv') do |row|
  employees << Employee_list.new(*row)
end

employees.each do |employee|
  puts employee.to_s
end






































