class Car
  attr_accessor :year, :make, :model, :length
  
  def initialize(year, make, model, length)
    @year = year
    @make = make
    @model = model
    @length = length
  end
  
  def to_s
    "Year: #{@year} | Make: #{@make} | Model: #{@model} | Length: #{@length}"
  end
end

require 'csv'

cars = Array.new
CSV.foreach('cars.csv') do |row|
  cars << Car.new(*row)
end

cars.each do |car|
  car  
end

#/home/technoblogical/MyGits/TasQQ-TraQQer/experimental/Version 2/cars.csv