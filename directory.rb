$line_width = 80
def interactive_menu
  students = []
  loop do
    # 1. print the menu and ask the user what to do
    puts "1. Input the students"
    puts "2. Show the students"
    puts "9. Exit"
    # 2. read the input and save it into a variable
    selection = gets.chomp
    # 3. do what the user has asked
    case selection
      when "1"
        # input the students
        students = input_students
      when "2"
        # show the students
        print_header
        print_list(students)
        print_footer(students)
      when "9"
        exit # causes the program to terminate
      else
        puts "I don't know what you mean, try again."
      end
    # 4. repeat from step 1
  end
end
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
    student_total = "Now we have #{students.count} student."
    if students.count > 1
      print student_total.gsub(".", "s.\n")
    else puts student_total
    end

    puts "Please enter the name of another student."
    puts "To finish hit return."
    # get another name from the user
    name = gets.delete("\n").capitalize
  end
  if students.count < 1
    puts "No students were entered.".center($line_width)
    interactive_menu
  end
  # return the array of students
  students
end

def print_header
  puts "The students of Villains Academy".center($line_width)
  puts "-------------".center($line_width)
end

def print_list(students)
  index = 0
  while index < students.length
    puts "#{index + 1}.#{students[index][:name]} (#{students[index][:cohort]} cohort, D.O.B: #{students[index][:dob]}, Country: #{students[index][:country_ob]}, Hobby: #{students[index][:hobby]})".ljust(80)
    index += 1
  end
end

def print_cohort(students)
  students.sort_by {|x| x[:cohort]}.each do |student|
      puts "#{student[:name]} (#{student[:cohort]} cohort, D.O.B: #{student[:dob]}, Country: #{student[:country_ob]}, Hobby: #{student[:hobby]})".ljust(80)
  end
end

def print_footer(students)
  puts "-------------".center($line_width)
  message = "Overall, we have #{students.count} great student."
  if students.count > 1
    print message.gsub(".", "s.\n").center($line_width)
  else
    puts message.center($line_width)
  end
  puts
end
# nothing happends until the methods are called

#print_cohort(students)
interactive_menu
