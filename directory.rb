require 'csv'
@students = []
def program_intro
  puts
  puts "WELCOME TO THE STUDENT DIRECTORY."
end

def print_menu
  puts
  puts "COMMANDS"
  puts "1. Input, 2: Show, 3: Save, 4: Load"
  puts "9. Exit"
  print "Type a number: "
end

def interactive_menu
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
      ask_for_file_to_load
    when "9"
      exit
    else
      puts; puts "I don't know what you meant, try again"
    end
end

def input_students
  puts; puts "Enter details for the first student."
  print "Name: ".rjust(10)
  while true
    name = STDIN.gets.delete("\n")
    break if name.empty?
    print "Age: ".rjust(10); age = STDIN.gets.delete("\n").to_sym
    print "Country: ".rjust(10); country = STDIN.gets.delete("\n").to_sym
    print "Cohort: ".rjust(10); cohort = STDIN.gets.delete("\n").to_sym
    add_to_students(name, age, country, cohort)
    puts; puts "'#{name}' added. #{@students.count} " +
    (@students.count == 1 ? "student" : "students") + " in total."
    puts "Input a new student's name (or hit enter to finish)"
    print "Name: ".rjust(10)
  end
  return @students.sort_by{|student| student[:name]}
end

def add_to_students(name, age=:"??", country=:Unknown, cohort=:September)
  age = :"??" if age == :""
  country = :Unknown if country == :""
  cohort = :September if cohort == :""
  @students << {name: name,  age: age.to_sym, country: country.to_sym, cohort: cohort.to_sym}
  return
end

def show_students
  unless @students.empty?
    print_header
    print_list_of(@students)
    print_footer
  else
    puts; puts "No students entered."
  end
end

def save_students
  puts; puts "Save to which file? (Hit return for default)"
  filename = STDIN.gets.chomp
  if File.exists?(filename)
    puts; puts "#{filename} already exists. If you continue it will be overwritten."
    print "Continue? (Y/n): "
    while true
      choice = STDIN.gets.chomp.upcase
      if choice.empty? then choice = "Y" end
      if choice == "N" #should either ask for filename again, or abort
        puts; puts "Save aborted"
        return
      elsif choice == "Y"
        break
      else
        puts; print "Please enter 'y' or 'n': "
      end
    end
  end
  if filename.empty? then filename = "students.csv" end
  CSV.open(filename, "w") {|student_file|
    @students.each {|student|
      student_file << student.values
    }
  }
  puts; puts "#{@students.count} students saved to #{filename}."
end

def ask_for_file_to_load
  puts; puts "Load from which file? (Hit return for default)"
  filename = STDIN.gets.chomp
  if File.exists?(filename)
    load_students(filename)
  else
    puts; puts "File not found."
  end
end

def load_students(filename = "students.csv")
  if filename.empty? then filename = "students.csv" end
  old_count = @students.count
  CSV.foreach(filename) {|row|
      name, age, country, cohort = row
      add_to_students(name, age, country, cohort)
  }
  puts; puts "Loaded #{@students.count - old_count} students from #{filename}." +
                                       " #{@students.count} students in total."
end

def try_load_students
  filename = ARGV.first
  if filename.nil? then filename = "students.csv" end
  if File.exists?(filename)
    load_students(filename)
  else
    puts; puts "Sorry, #{filename} doesn't exist."
    exit # quit the program
  end
end

def print_header
  puts
  puts "Students of Villains Academy"
  puts "-----------------------------------------------"
end

def ask_for_letter
  puts; print "Print students beginning with which letter? "
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
  puts; puts "Total students: #{@students.count}"
end

program_intro
try_load_students
interactive_menu
