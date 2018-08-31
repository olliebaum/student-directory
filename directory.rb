#Put the students in an array
def input_students
  students = []
  puts "Type the names of the students to add:"
  puts "(Hit return twice to finish)"
  while true
    name = gets.chomp
    break if name.empty?
    students << {name: name, cohort: :september}
    puts "#{students.count} students in total."
  end
  return students
end
def print_header
  puts "Students of Villains Academy"
  puts "----------------------------"
end

def ask_for_letter
  print "Print students beginning with which letter? "
  letter = gets.chomp
end
def print_list_of(students, letter)
  students.select{|student|
    student[:name].chars.first.downcase == letter.downcase && student[:name].length < 12
  }.each.with_index(1) { |student, index|
      puts "#{index}. #{student[:name]} (#{student[:cohort]} cohort)"
  }
end
def print_list_of_all(students)
  i = 0
  while i < students.count
    puts "#{i+1}. #{students[i][:name]} (#{students[i][:cohort]} cohort)"
    i += 1
  end
end
def print_footer(students)
puts "(N.B. Students with 12 or more characters in their name were omitted.)"
puts "Overall, we have #{students.count} great students"
end

students = input_students
print_header
print_list_of_all(students)
#print_list_of(students, ask_for_letter)
print_footer(students)
