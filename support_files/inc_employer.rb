class Employer
  def initialize ( name )
    @name = name
    @employees_file_path = File.join("support_files",@name,"employees.csv")
    @tasks_file_path = File.join("support_files",@name,"tasks.csv")
    @number_of_employees = 0
    @number_of_tasks = 0
    @employees = []
    @tasks = []
    CSV.foreach(@employees_file_path) do |row|
    	@number_of_employees = @number_of_employees + 1
    	@employees << row
    end #end CSV.foreach
    CSV.foreach(@tasks_file_path) do |row|
      @number_of_tasks = @number_of_tasks + 1
      @tasks << row
    end #end CSV.foreach
  end #end initialize

  def name
  	@name
  end #end name

  def employees_file_path
  	@employees_file_path
  end #end employees_file_path

  def tasks_file_path
    @tasks_file_path
  end #end tasks_file_path

  def employees_raw_data
  	@employees
  end #end employees_raw_data

  def tasks_raw_data
    @tasks
  end #end tasks_raw_data

  def number_of_employees
  	@number_of_employees
  end #end number_of_emploees

  def number_of_tasks
    @number_of_tasks
  end #end number_of_tasks

  def employees_printout
    printout=""
  	@employees.each { |person|
    printout << "Employees ID:"+ person[0].ljust(5)
    printout <<  "Last Name:"+person[1].ljust(20)
    printout <<  "First Name:"+person[2].ljust(20)
    printout << "Pay Rate:" + person[3].ljust(6)
    printout << "\n"}
    printout
  end #end employees_printout

  def tasks_printout
    printout=""
    @tasks.each { |tasks|
    printout <<  "Tasks ID:"+ tasks[0].ljust(5)
    printout <<  "Employees ID:"+tasks[1].ljust(5)
    printout <<  "Description:" + tasks[4].ljust(50)
    printout <<  "\n"
    printout <<  "Started:"+Time.at(tasks[2].to_i).ctime.ljust(40)
    if tasks[3]==" "
      printout << "Stopped: ".ljust(40)
    else
      printout <<  "Stopped:" +Time.at(tasks[3].to_i).ctime.ljust(40)
    end #end if tasks[3]==" "
    printout <<  "\n"
    printout << "\n"}
    printout
  end #end tasks_printout

  def add_employees (last_name,first_name,pay_rate)
    @number_of_employees = @number_of_employees + 1
    #               Employee ID             ,LN       ,FN        ,Pay Rate     ,Tasks,ClockedIN?,ClockedInTime,SecondsWorked
    @employees << [@number_of_employees.to_s,last_name,first_name,pay_rate.to_s," "  ,"n"       ," "            ,"0"]
  end #end add_employees

  def save
    File.open(@employees_file_path, "w") do |f|
      @employees.each {|employees|
        joined_data = employees.join(',')
        f.puts joined_data
      }
    end  #end File.open(@employees_file_path, "w") do |f|

    File.open(@tasks_file_path, "w") do |f|
      @tasks.each {|tasks|
        joined_data = tasks.join(',')
        f.puts joined_data
      }
    end #end File.open(@tasks_file_path, "w") do |f|
  end #end save

  def start_task(employee_id,description_of_task)
      @number_of_tasks = @number_of_tasks + 1
      #          TaskIDNumber         ,EmplyoyeeID     ,TimeStarted       ,TimeEnded,DescriptionOfTask
      @tasks << [@number_of_tasks.to_s,employee_id.to_s,Time.now.to_i.to_s," "      ,description_of_task]
      @employees.each { |employee|
        if employee[0] == employee_id.to_s
          employee[4] << " " + @number_of_tasks.to_s
          if employee[5] = "n"
            employee[5] = "y"
            employee[6] = Time.now.to_i.to_s
          end #end if person[5] = "n"
        end #end if person[0] == employee_id.to_s
      }
  end #end start_task(employee_id,description_of_task)

  def end_task(employee_id)
    end_time = Time.now.to_i.to_s
    @tasks.each {|task|
      if task[1] == employee_id.to_s
        if task[3] == " "
          task[3] = end_time
        end
      end #end task[1] = employee_id.to_s
    }
  end #end end_task

  def clock_out(employee_id)
    clock_out_time = Time.now.to_i
    @employees.each { |employee|
      if employee[0] == employee_id.to_s
        clock_in_time = employee[6].to_i
        total_time_today = clock_out_time - clock_in_time
        total_time = employee[7].to_i + total_time_today
        employee[7] = total_time.to_s
        employee[5] = "n"
      end #end employee[0] == employee_id.to_s
    }
    @tasks.each {|task|
      if task[1]==employee_id.to_s
        if task[3]==" "
          task[3]=clock_out_time.to_s
        end #end task[3]==" "
      end #end task[1]==employee_id.to_s
    }
  end #end clock_out

  def hours(employee_id)
    hours = 0
    @employees.each {|employee|
      if employee[0] == employee_id.to_s
        hours = employee[7].to_i
      end
    }
    hours = hours/3600.to_f
    hours.to_s
  end #end hours

  def payroll
    payroll_printout=""
    @employees.each{ |employee|
      temporary_employee_name = employee[1].to_s+", "+employee[2].to_s
      hours = employee[7]
      hours = hours.to_f
      hours = hours/3600
      hours = hours.round(4)
      hours = hours*employee[3].to_f
      hours = hours.round(2)
      payroll_printout<<"Name:"+temporary_employee_name.ljust(40)
      payroll_printout<<"\n"
      payroll_printout<<"ID:"+employee[0].to_s.ljust(3)
      payroll_printout<<"Paycheck Amount:" +hours.to_s
      payroll_printout<<"\n\n"
    }
    payroll_printout
  end
    
end #end 