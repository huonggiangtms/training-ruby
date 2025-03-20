require 'sqlite3'

class Student
  attr_accessor :id_student, :name, :age, :mark

  def initialize(id_student, name, age, mark)
    @id_student = id_student
    @name = name
    @age = age.to_i
    @mark = mark.to_f
  end

  def to_s
    "ID: #{@id_student}, Name: #{@name}, Age: #{@age}, Mark: #{@mark}"
  end
end

class StudentManagement
  DB_NAME = "students.db"

  def initialize
    @db = SQLite3::Database.new DB_NAME
    create_table
  end

  def create_table
    @db.execute <<-SQL
      CREATE TABLE IF NOT EXISTS students (
        id_student TEXT PRIMARY KEY,
        name TEXT,
        age INTEGER,
        mark FLOAT
      );
    SQL
  end

  def add_student(student)
    @db.execute "INSERT INTO students (id_student, name, age, mark) VALUES (?, ?, ?, ?)", 
                [student.id_student, student.name, student.age, student.mark]
  end

  def list_students
    @db.execute("SELECT * FROM students").map do |row|
      Student.new(row[0], row[1], row[2], row[3])
    end
  end

  def find_student(id_student)
    row = @db.execute("SELECT * FROM students WHERE id_student = ?", [id_student]).first
    row ? Student.new(row[0], row[1], row[2], row[3]) : nil
  end

  def student_with_highest_mark
    row = @db.execute("SELECT * FROM students ORDER BY mark DESC LIMIT 1").first
    row ? Student.new(row[0], row[1], row[2], row[3]) : nil
  end

  def filter_students_by_age(age)
    @db.execute("SELECT * FROM students WHERE age = ?", [age]).map do |row|
      Student.new(row[0], row[1], row[2], row[3])
    end
  end

  def average_mark
    result = @db.execute("SELECT AVG(mark) FROM students").first
    result ? result[0].to_f.round(2) : 0
  end

  def delete_student(id_student)
    @db.execute("DELETE FROM students WHERE id_student = ?", [id_student])
  end

  def menu
    loop do
      puts "------------------------------------"
      puts "| Student Management System         |"
      puts "| 1. Add a new student              |"
      puts "| 2. List students                  |"
      puts "| 3. Find student by ID             |"
      puts "| 4. Find student with highest mark |"
      puts "| 5. Filter students by age         |"
      puts "| 6. Average mark of class          |"
      puts "| 7. Delete student by ID           |"
      puts "| 8. Exit                           |"
      puts "------------------------------------"
      print "Enter your choice: "
      choice = gets.chomp.to_i

      case choice
      when 1
        print "Enter student ID: "
        id_student = gets.chomp
        print "Enter student name: "
        name = gets.chomp
        print "Enter student age: "
        age = gets.chomp.to_i
        print "Enter student mark: "
        mark = gets.chomp.to_f
        add_student(Student.new(id_student, name, age, mark))
        puts "Student added successfully!"
      when 2
        puts "List of students:"
        list_students.each { |s| puts s }
      when 3
        print "Enter student ID to find: "
        id_student = gets.chomp
        student = find_student(id_student)
        puts student ? student : "Student not found."
      when 4
        student = student_with_highest_mark
        puts student ? "Student with highest mark: #{student}" : "No students found."
      when 5
        print "Enter age to filter: "
        age = gets.chomp.to_i
        students = filter_students_by_age(age)
        if students.any?
          puts "Students with age #{age}:"
          students.each { |s| puts s }
        else
          puts "No students found with age #{age}."
        end
      when 6
        puts "Average mark of the class: #{average_mark}"
      when 7
        print "Enter student ID to delete: "
        id_student = gets.chomp

        student = find_student(id_student)

        if student
          delete_student(id_student) 
          puts "Student deleted successfully!"
        else
          puts "Student not found."
        end
      when 8
        puts "Goodbye! See you later :>"
        break
      else
        puts "Invalid choice. Please enter a number from 1 to 8 :)))"
      end
    end
  end
end

student_management = StudentManagement.new
student_management.menu
