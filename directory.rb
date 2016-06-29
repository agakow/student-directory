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
  puts space + "2. Show the students"
  puts space + "3. Save the list to students.csv"
  puts space + "4. Load the list from students.csv"
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
  name = get_name
  while !name.empty? do
    cohort = get_cohort
    dob = get_dob
    country = get_country
    hobby = get_hobby
    add_info(name, cohort, dob, country, hobby)
    student_total
    puts "Please enter the name of another student."
    puts "To finish hit return."
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
  puts "Please enter the names of the students."
  puts "To finish, just hit return."
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
  puts "Please enter the students' date of birth. (dd/mm/yyyy)"
  dob = STDIN.gets.chomp
  dob = "unknown" if dob.empty?
  dob
end

def get_country
  puts "Please enter the students' country of birth."
  puts "If unknown, hit return."
  country = STDIN.gets.chomp.capitalize
  country = "unknown" if country.empty?
  country
end

def get_hobby
  puts "Please enter the students' hobby"
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

def print_list
  print "NO.".center(10)
  print "NAME".center(20)
  print "COHORT".center(20)
  print "D.O.B".center(20)
  print "COUNTRY".center(20)
  puts "HOBBY".center(20)
  puts "-" * @line_width
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
  @students.sort_by {|x| x[:cohort]}.each do |student|
      puts "#{student[:name]} (#{student[:cohort]} cohort, D.O.B: #{student[:dob]}, Country: #{student[:country]}, Hobby: #{student[:hobby]})"
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
  file = File.open("students.csv", "w")
  @students.each do |student|
    student_data = [student[:name], student[:cohort], student[:dob], student[:country], student[:hobby]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def load_students(filename = "students.csv")
  file = File.open(filename, "r")
  file.readlines.each do |line|
    name, cohort, dob, country, hobby = line.chomp.split(',')
    add_info(name, cohort, dob, country, hobby)
  end
  file.close
end

def try_load_students
  filename = ARGV.first
  filename = "students.csv" if filename.nil?
  if File.exists?(filename)
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}".center(@line_width)
  else
    puts "Sorry, #{filename} doesn't exist.".center(@line_width)
    exit
  end
end

try_load_students
interactive_menu
