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

	def my_all?
		self.my_each {|value| return false if !yield(value)} 
		true
	end

	def my_any?
		self.my_each {|value| return true if yield(value)}
		false
	end

	def my_none?
		self.my_each {|value| return false if yield(value)}
		true
	end

	def my_count(object_sought = "empty")
		count = 0
		if block_given?
			self.my_each {|value| count += 1 if yield(value)}
		elsif object_sought == "empty"
			return self.length
		else
			self.my_each {|value| count += 1 if value == object_sought}
		end
		count
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

puts "Testing #my_all?:"

array1 = [3, "fish", "truth", :symbol]
array2 = [3, 2, 5, 12, 19]

puts array1.all? {|value| value.is_a? Integer}
puts array1.my_all? {|value| value.is_a? Integer}

puts array2.all? {|value| value.is_a? Integer}
puts array2.my_all? {|value| value.is_a? Integer}
puts

puts "Testing #my_any?:"

array1 = [3, "fish", "truth", :symbol]
array2 = [3, 2, 5, 12, 19]

puts array1.any? {|value| value.is_a? String}
puts array1.my_any? {|value| value.is_a? String}

puts array2.any? {|value| value.is_a? String}
puts array2.my_any? {|value| value.is_a? String}
puts

puts "Testing #my_none?:"

array1 = [3, "fish", "truth", :symbol]
array2 = [3, 2, 5, 12, 19]

puts array1.none? {|value| value.is_a? String}
puts array1.my_none? {|value| value.is_a? String}

puts array2.none? {|value| value.is_a? String}
puts array2.my_none? {|value| value.is_a? String}
puts

puts "Testing #my_count:"

array = [3, 2, 6, 2, 19]

puts array.count
puts array.my_count

puts array.count(2)
puts array.my_count(2)

puts array.count(7)
puts array.my_count(7)

puts array.count {|value| value%3 == 0}
puts array.my_count {|value| value%3 == 0}