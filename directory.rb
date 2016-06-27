def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return."
  students = []
  name = gets.chomp.capitalize
  # while the name is not empty. repeat this code
  while !name.empty? do
    puts "Please enter cohort month"
    cohort = gets.chomp.capitalize.to_sym
    month = [:January, :February, :March, :April, :May, :June, :July, :August, :September, :October, :November, :December]
      while !month.include?(cohort) || cohort.empty? do
        if cohort.empty?
          cohort = month[Time.now.month - 1]
        elsif !month.include?(cohort)
         puts "Please enter a valid month or hit return for default (current month)."
         cohort = gets.chomp.capitalize.to_sym
        end
      end
    puts "Please enter date of birth for #{name} (dd-mm-yyyy)"
    dob = gets.chomp
    puts "Please enter the country of birth for #{name}."
    puts "If unknown, hit return."
    country_ob = gets.chomp.capitalize
      while country_ob.empty?
        country_ob = "unknown"
      end
    puts "Please enter #{name}'s hobby"
    puts "If unknown, hit return."
    hobby = gets.chomp.capitalize
      while hobby.empty?
      hobby = "unknown"
      end
    students << {name: name, cohort: cohort, dob: dob, country_ob: country_ob, hobby: hobby}
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
  puts "The students of Villains Academy".center(80)
  puts "-------------".center(80)
end

def print(students)
  index = 0
  while index < students.length
    puts "#{index + 1}.#{students[index][:name]} (#{students[index][:cohort]} cohort, D.O.B: #{students[index][:dob]}, Country: #{students[index][:country_ob]}, Hobby: #{students[index][:hobby]})".center(80)
    index += 1
  end
end

def print_cohort(students)
  students.sort_by {|x| x[:cohort]}.each do |student|
      puts "#{student[:name]} (#{student[:cohort]} cohort, D.O.B: #{student[:dob]}, Country: #{student[:country_ob]}, Hobby: #{student[:hobby]})".center(80)
  end
end


def print_footer(students)
  puts "-------------".center(80)
  puts "Overall, we have #{students.count} great students".center(80)
end
# nothing happends until the methods are called

students = input_students
print_header
#print(students)
print_cohort(students)
print_footer(students)
