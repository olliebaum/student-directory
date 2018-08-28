#First the code prints a list of the students
students = [
  "Dr. Hannibal Lecter",
  "Darth Vader",
  "Nurse Ratched",
  "Michael Corleone",
  "Alex DeLarge",
  "The Wicked Witch of the West",
  "Terminator",
  "Freddy Krueger",
  "The Joker",
  "Joffrey Baratheon",
  "Norman Bates"
]
puts "Students of Villains Academy"
puts "----------------------------"
students.each { |student| puts student }

#Then it prints a count of the students
puts "Overall, we have #{students.count} great students"
