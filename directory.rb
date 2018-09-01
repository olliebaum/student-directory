def program_intro
  puts
  puts "WELCOME TO THE STUDENT DIRECTORY."
  puts "Enter a list of students, and they will be printed for you."
  puts
end

def input_students
  students = []
  puts "Enter details for the first student."
  print "Name: ".rjust(10)
  while true
    name = gets.chomp
    break if name.empty?
    print "Age: ".rjust(10); age = gets.chomp.to_sym
    print "Country: ".rjust(10); country = gets.chomp.to_sym
    print "Cohort: ".rjust(10); cohort = gets.chomp.to_sym
    age = :"??" if age == :""
    country = :Unknown if country == :""
    cohort = :September if cohort == :""
    students << {name: name,  age: age, country: country, cohort: cohort}
    puts "'#{name}' added. #{students.count} " +
    (students.count == 1 ? "student" : "students") + " in total."
    puts "Input a new student's name (or hit enter to finish):"
  end
  return students
end

def print_header
  puts "Students of Villains Academy"
  puts "-----------------------------------------------"
end

def ask_for_letter
  print "Print students beginning with which letter? "
  letter = gets.chomp
end

def print_list_of(students, letter)
  students.select{|student|
    student[:name].chars.first.downcase == letter.downcase && student[:name].length < 12
  }.each.with_index(1) { |student, index|
       puts align_student_data(student,index)
    }  
  puts "(N.B. Students with 12 or more characters in their name were omitted.)"
end

def print_list_of_all(students)
  i = 0
  puts align_student_data(
    {name: "Name",  age: "Age", country: "Country", cohort: "Cohort"}, "#")
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

def print_footer(students)
  puts "Total students: #{students.count}"
end

program_intro
students = input_students
print_header
print_list_of_all(students)
#print_list_of(students, ask_for_letter)
print_footer(students)
