module Enumerable
	def my_each
		return to_enum(:my_each) unless block_given?
		self.length.times do |num|
			yield(self[num])
		end
		self
	end

	def my_each_with_index
		return to_enum(:my_each_with_index) unless block_given?
		self.length.times do |num|
			yield(self[num], num)
		end
		self
	end

	def my_select
		return to_enum(:my_select) unless block_given?
		selected_array = []
		self.my_each { |value| selected_array << value if yield(value)}
		selected_array
	end
end

puts "Testing #my_each:"

array1 = [3, "fish", "truth", :symbol]

puts array1.each {|x| puts "#{x} tacos"}.inspect
puts array1.my_each {|x| puts "#{x} tacos"}.inspect

puts array1.each.inspect
puts array1.my_each.inspect
puts

puts "Testing #my_each_with_index:"

array1 = [3, "fish", "truth", :symbol]

puts array1.each_with_index {|value, index| puts "#{value} is at index #{index}"}.inspect
puts array1.my_each_with_index {|value, index| puts "#{value} is at index #{index}"}.inspect

puts array1.each_with_index.inspect
puts array1.my_each_with_index.inspect
puts

puts "Testing #my_select:"

array1 = [3, "fish", "truth", :symbol]

puts array1.select {|value| value.is_a? String}.inspect
puts array1.my_select {|value| value.is_a? String}.inspect

puts array1.select.inspect
puts array1.my_select.inspect
puts