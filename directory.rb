@students = []

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit"
end

def show_students
  print_header
  print_list
  print_footer
end

def process(selection)
  case selection
    when "1"
      input_students
    when "2"
      show_students
    when "3"
      save_students
    when "4"
      load_students
    when "9"
      exit
    else
      puts "I don't know what you mean, try again."
  end
end

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return."
  name = STDIN.gets.chomp.capitalize
  while !name.empty? do
    puts "Please enter cohort month"
    cohort = STDIN.gets.chomp.capitalize.to_sym
    month = [:January, :February, :March, :April, :May, :June, :July, :August, :September, :October, :November, :December]
      while !month.include?(cohort) || cohort.empty? do
        if cohort.empty?
          cohort = month[Time.now.month - 1]
        elsif !month.include?(cohort)
         puts "Please enter a valid month or hit return for default (current month)."
         cohort = STDIN.gets.chomp.capitalize.to_sym
        end
      end
    puts "Please enter date of birth for #{name} (dd/mm/yyyy)"
    dob = STDIN.gets.chomp
      if dob.empty?
        dob = "unknown"
      end
    puts "Please enter the country of birth for #{name}."
    puts "If unknown, hit return."
    country_ob = STDIN.gets.chomp.capitalize
      while country_ob.empty?
        country_ob = "unknown"
      end
    puts "Please enter #{name}'s hobby"
    puts "If unknown, hit return."
    hobby = STDIN.gets.chomp.capitalize
      while hobby.empty?
      hobby = "unknown"
      end
    @students << {name: name, cohort: cohort, dob: dob, country_ob: country_ob, hobby: hobby}
    student_total = "Now we have #{@students.count} student."
    if @students.count > 1
      print student_total.gsub(".", "s.\n")
    else puts student_total
    end
    puts "Please enter the name of another student."
    puts "To finish hit return."
    name = STDIN.gets.chomp.capitalize
  end
  if @students.count < 1
    puts "No students were entered.".center(80)
    interactive_menu
  end
  @students
end

def print_header
  puts "The students of Villains Academy".center(80)
  puts "--------------------".center(80)
end

def print_list
  count = 1
  @students.each do |student|
    puts (count.to_s + ".#{student[:name]} (Cohort: #{student[:cohort]}, D.O.B: #{student[:dob]}, Country: #{student[:country_ob]}, Hobby: #{student[:hobby]})").center(80)
    count += 1
  end
end

def print_cohort
  @students.sort_by {|x| x[:cohort]}.each do |student|
      puts "#{student[:name]} (#{student[:cohort]} cohort, D.O.B: #{student[:dob]}, Country: #{student[:country_ob]}, Hobby: #{student[:hobby]})".center(80)
  end
end

def print_footer
  puts "--------------------".center(80)
  message = "Overall, we have #{@students.count} great student."
  if @students.count > 1
    print message.gsub(".", "s.\n").center(80)
  else
    puts message.center(80)
  end
  puts
end

def save_students
  file = File.open("students.csv", "w")
  @students.each do |student|
    student_data = [student[:name], student[:cohort], student[:dob], student[:country_ob], student[:hobby]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def load_students(filename = "students.csv")
  file = File.open(filename, "r")
  file.readlines.each do |line|
    name, cohort, dob, country_ob, hobby = line.chomp.split(',')
    @students << {name: name, cohort: cohort.to_sym, dob: dob, country_ob: country_ob, hobby: hobby}
  end
  file.close
end

def try_load_students
  filename = ARGV.first
  return if filename.nil?
  if File.exists?(filename)
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else
    puts "Sorry, #{filename} doesn't exist."
    exit
  end
end

try_load_students
interactive_menu
