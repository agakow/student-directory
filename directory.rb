def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # creating an empty array
  students = []
  # get the first name
  name = gets.chomp.capitalize
  # while the name is not empty. repeat this code
  while !name.empty? do
    students << {name: name, cohort: :november}
    puts "Now we have #{students.count} students"
    # get another name from the user
    name = gets.chomp.capitalize
  end
  # return the array of students
  students
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print(students)
  puts "Starting with which letter would you like to see student names?"
  letter = gets.chomp.capitalize
  students.each_with_index do |student, index|
    if letter == student[:name][0]
      if student[:name].length < 12
        puts "#{index + 1}.#{student[:name]} (#{student[:cohort]} cohort)"
      end
    end
  end
end

def print_footer(students)
  puts "Overall, we have #{students.count} great students"
end
# nothing happends until the methods are called

students = input_students
print_header
print(students)
print_footer(students)
