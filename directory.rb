@students = []
def program_intro
  puts
  puts "WELCOME TO THE STUDENT DIRECTORY."
  puts
end

def print_menu
  puts "COMMANDS"
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save students"
  puts "4. Load students"
  puts "9. Exit"
  print "Type a number: "
end

def interactive_menu
  program_intro
  loop do
    print_menu
    command(STDIN.gets.chomp)
  end
end

def command(selection)
  case selection
    when "1"
      @students = input_students
    when "2"
      show_students
    when "3"
      save_students
    when "4"
      load_students
    when "9"
      exit
    else
      puts "I don't know what you meant, try again"
    end
end

def input_students
  puts "Enter details for the first student."
  print "Name: ".rjust(10)
  while true
    name = STDIN.gets.delete("\n")
    break if name.empty?
    print "Age: ".rjust(10); age = STDIN.gets.delete("\n").to_sym
    print "Country: ".rjust(10); country = STDIN.gets.delete("\n").to_sym
    print "Cohort: ".rjust(10); cohort = STDIN.gets.delete("\n").to_sym
    age = :"??" if age == :""
    country = :Unknown if country == :""
    cohort = :September if cohort == :""
    @students << {name: name,  age: age, country: country, cohort: cohort}
    puts "'#{name}' added. #{@students.count} " +
    (@students.count == 1 ? "student" : "students") + " in total."
    puts "Input a new student's name (or hit enter to finish)"
    print "Name: ".rjust(10)
  end
  return @students.sort_by{|student| student[:name]}
end

def show_students
  unless @students.empty?
    print_header
    print_list_of(@students)
    print_footer
  else
    puts "No students entered."
  end
end

def save_students
  student_file = File.open("students.csv", "w")
  @students.each {|student|
    line = student.values.join(",")
    student_file.puts(line)
  }
  student_file.close
  puts "Students saved."
end

def load_students(filename = "students.csv")
  student_file = File.open(filename, "r")
  student_file.readlines.each do |line|
    name, age, country, cohort = line.chomp.split(",")
    @students << {name: name, age: age.to_sym, country: country.to_sym, cohort: cohort.to_sym}
  end
  student_file.close
end

def try_load_students
  filename = ARGV.first
  return if filename.nil?
  if File.exists?(filename)
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else
    puts "Sorry, #{filename} doesn't exist."
    exit # quit the program
  end
end

def print_header
  puts "Students of Villains Academy"
  puts "-----------------------------------------------"
end

def ask_for_letter
  print "Print students beginning with which letter? "
  letter = STDIN.gets.delete("\n")
end

def print_list_of(students)
  truncated = false
  students.sort_by {|student| student[:cohort]
  }.each.with_index(1) { |student, index|
      if student[:name].length > 15 then
        student[:name] = student[:name].slice(0...14) + "*"
        truncated = true
      end
      puts align_student_data(student,index)
    }
  puts "* Name has been truncated." if truncated
end

def print_list_of_all(students)
  puts align_student_data(
    {name: "Name",  age: "Age", country: "Country", cohort: "Cohort"}, "#")
  i = 0
  while i < students.count
    puts align_student_data(students[i], i+1)
    i += 1
  end
  puts "-----------------------------------------------"
end

def align_student_data(student, index)
  "#{index}.".ljust(4) +
  "#{student[:name]}".ljust(20) +
  "#{student[:age]}".ljust(4) +
  "#{student[:country]}".ljust(11) +
  "#{student[:cohort]}".ljust(11)
end

def print_footer
  puts "Total students: #{@students.count}"
end

try_load_students
interactive_menu
