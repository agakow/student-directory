$line_width = 80
def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return."
  students = []
  name = gets.delete("\n").capitalize
  # while the name is not empty. repeat this code
  while !name.empty? do
    puts "Please enter cohort month"
    cohort = gets.delete("\n").capitalize.to_sym
    month = [:January, :February, :March, :April, :May, :June, :July, :August, :September, :October, :November, :December]
      while !month.include?(cohort) || cohort.empty? do
        if cohort.empty?
          cohort = month[Time.now.month - 1]
        elsif !month.include?(cohort)
         puts "Please enter a valid month or hit return for default (current month)."
         cohort = gets.delete("\n").capitalize.to_sym
        end
      end
    puts "Please enter date of birth for #{name} (dd-mm-yyyy)"
    dob = gets.delete("\n")
    puts "Please enter the country of birth for #{name}."
    puts "If unknown, hit return."
    country_ob = gets.delete("\n").capitalize
      while country_ob.empty?
        country_ob = "unknown"
      end
    puts "Please enter #{name}'s hobby"
    puts "If unknown, hit return."
    hobby = gets.delete("\n").capitalize
      while hobby.empty?
      hobby = "unknown"
      end
    students << {name: name, cohort: cohort, dob: dob, country_ob: country_ob, hobby: hobby}
    puts "Now we have #{students.count} students."
    puts "Please enter the name of another student."
    puts "To finish hit return."
    # get another name from the user
    name = gets.delete("\n").capitalize
  end
  # return the array of students
  students
end

def print_header
  puts "The students of Villains Academy".center($line_width)
  puts "-------------".center($line_width)
end

def print(students)
  index = 0
  while index < students.length
    puts "#{index + 1}.#{students[index][:name]} (#{students[index][:cohort]} cohort, D.O.B: #{students[index][:dob]}, Country: #{students[index][:country_ob]}, Hobby: #{students[index][:hobby]})".center($line_width)
    index += 1
  end
end

def print_cohort(students)
  students.sort_by {|x| x[:cohort]}.each do |student|
      puts "#{student[:name]} (#{student[:cohort]} cohort, D.O.B: #{student[:dob]}, Country: #{student[:country_ob]}, Hobby: #{student[:hobby]})".center($line_width)
  end
end

def print_footer(students)
  puts "-------------".center($line_width)
  if students.count < 1
    puts "Currently, there are no students at Villains Academy".center($line_width)
  elsif students.count == 1
    puts "Overall, we have 1 great student".center($line_width)
  else
    puts "Overall, we have #{students.count} great student".center($line_width)
  end
end
# nothing happends until the methods are called

students = input_students
print_header
print(students)
#print_cohort(students)
print_footer(students)
