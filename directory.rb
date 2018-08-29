require 'csv'
@students = []
@line_width = 110

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def print_menu
  puts
  puts ("-" * 50).center(@line_width)
  puts "VILLAINS ACADEMY STUDENT DIRECTORY".center(@line_width)
  puts ("-" * 50).center(@line_width)
  space = " " * (@line_width/3)
  puts space + "1. Input the students"
  puts space + "2. Show the student list"
  puts space + "3. Save student list to a file"
  puts space + "4. Load a student list from file"
  puts space + "9. Exit"
end

def show_students
  if @students.count < 1
    no_students
  else
    print_header
    print_list
    print_footer
  end
end

def process(selection)
  case selection
    when "1"
      puts "---You've chosen to input new students---"
      input_students
    when "2"
      puts "---You've chosen to display the student list---".center(@line_width)
      show_students
    when "3"
      puts "---You've chosen to save the current student list---"
      save_students
    when "4"
      puts "---You've chosen to load the student list from a file---"
      load_students
    when "9"
      puts "---You've chosen to exit the progam. Goodbye!---".center(@line_width)
      puts
      exit
    else
      puts "---I don't know what you mean, try again---".center(@line_width)
  end
end

def input_students
  name = get_name
  while !name.empty? do
    cohort = get_cohort
    dob = get_dob
    country = get_country
    hobby = get_hobby
    add_info(name, cohort, dob, country, hobby)
    student_total
    puts "Please enter the name of another student:"
    puts "(Hit return to go back to the menu)"
    name = STDIN.gets.chomp.capitalize
  end
  no_students if @students.count < 1
end

def no_students
    puts ("-" * 50).center(@line_width)
    puts "Currently, there are no students at Villains Academy".center(@line_width)
    puts ("-" * 50).center(@line_width)
end

def student_total
  s_count = "Now we have #{@students.count} student."
  if @students.count > 1
    print s_count.gsub(".", "s.\n")
  else
    puts s_count
  end
end

def get_name
  puts "Please enter the name of the student:"
  puts "(Hit return to go back to the menu)"
  STDIN.gets.chomp.capitalize
end

def get_cohort
  puts "Which cohort does the student belong to? (month)"
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
  cohort
end

def get_dob
  puts "Please enter the students' date of birth: (dd/mm/yyyy)"
  dob = STDIN.gets.chomp
  dob = "unknown" if dob.empty?
  dob
end

def get_country
  puts "Please enter the students' country of birth:"
  puts "If unknown, hit return."
  country = STDIN.gets.chomp.capitalize
  country = "unknown" if country.empty?
  country
end

def get_hobby
  puts "Please enter the students' hobby:"
  puts "If unknown, hit return."
  hobby = STDIN.gets.chomp.capitalize
  hobby = "unknown" if hobby.empty?
  hobby
end

def add_info(name, cohort, dob, country, hobby)
  @students << {name: name, cohort: cohort, dob: dob, country: country, hobby: hobby}
end

def print_header
  puts "The students of Villains Academy".center(@line_width)
  puts "-" * @line_width
end

def print_list_titles
  print "NO.".center(10)
  print "NAME".center(20)
  print "COHORT".center(20)
  print "D.O.B".center(20)
  print "COUNTRY".center(20)
  puts "HOBBY".center(20)
  puts "-" * @line_width
end

def print_list
  print_list_titles
  count = 1
  @students.each do |student|
    print count.to_s.center(10)
    print "#{student[:name]}".center(20)
    print "#{student[:cohort]}".center(20)
    print "#{student[:dob]}".center(20)
    print "#{student[:country]}".center(20)
    puts "#{student[:hobby]}".center(20)
    count += 1
  end
end

def print_cohort
  print_list_titles
  count = 1
  @students.sort_by {|x| x[:cohort]}.each do |student|
    print count.to_s.center(10)
    print "#{student[:name]}".center(20)
    print "#{student[:cohort]}".center(20)
    print "#{student[:dob]}".center(20)
    print "#{student[:country]}".center(20)
    puts "#{student[:hobby]}".center(20)
    count += 1
  end
end

def print_footer
  puts "-" * @line_width
  message = "Overall, we have #{@students.count} great student."
  if @students.count > 1
    print message.gsub(".", "s.\n").center(@line_width)
  else
    puts message.center(@line_width)
  end
  puts
end

def save_students
  puts "What would you like to save your file as?"
  puts "(Hit return to go back to the menu)"
  @file_name = STDIN.gets.chomp
  if @file_name.empty?
    interactive_menu
  else
    write_file
  end
end

def write_file
  CSV.open(@file_name, "w") do |file|
    @students.each do |student|
      file << [student[:name], student[:cohort], student[:dob], student[:country], student[:hobby]]
    end
  end
end

def load_file(filename = @file_load)
  CSV.foreach(filename) do |row|
    name, cohort, dob, country, hobby = row
    add_info(name, cohort, dob, country, hobby)
  end
end

def load_students
  puts "Which file would you like to load?"
  puts "(Hit return to go back to the menu)"
  @file_load = STDIN.gets.chomp
  if @file_load.empty?
    interactive_menu
  else
    load_file
  end
end

def try_load_students
  filename = ARGV.first
  filename = "students.csv" if filename.nil?
  if File.exists?(filename)
    load_file(filename)
    puts "Loaded #{@students.count} from default file #{filename}".center(@line_width)
  else
    puts "Sorry, #{filename} doesn't exist.".center(@line_width)
    exit
  end
end

try_load_students
interactive_menu
