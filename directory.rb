def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return."
  # creating an empty array
  students = []
  # get the first name
  name = gets.chomp.capitalize
  # while the name is not empty. repeat this code
  while !name.empty? do
    puts "Please enter date of birth for #{name} (dd/mm/yyyy)"
    dob = gets.chomp
    puts "Please enter the country of birth for #{name}."
    puts "If unknown, hit return."
    country_ob = gets.chomp.capitalize
      while country_ob.empty?
        country_ob = "unknown"
      end
    puts "Please enter #{name}'s hobby"
    hobby = gets.chomp
    students << {name: name, cohort: :november, dob: dob, country_ob: country_ob, hobby: hobby}
    puts "Now we have #{students.count} students."
    puts "Please enter the name of another student."
    puts "To finish hit return."
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
  index = 0
  while index < students.length
    puts "#{index + 1}.#{students[index][:name]} (#{students[index][:cohort]} cohort, D.O.B: #{students[index][:dob]}, Country: #{students[index][:country_ob]}, Hobby: #{students[index][:hobby]})"
    index += 1
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
