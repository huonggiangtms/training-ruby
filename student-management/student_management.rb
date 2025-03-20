
# 1. Tạo một mảng chứa thông tin sinh viên, mỗi sinh viên là một hash với các thông tin sau:
# Mã sinh viên (ma_sv)
# Tên sinh viên (ten)
# Tuổi (tuoi)
# Điểm (diem)
students = [
  {id_student: "sv0001", name: "Giang", age: 21, mark: 8.5},
  {id_student: "sv0002", name: "Giang2", age: 21, mark: 9.5}
]

begin
  puts "------------------------------------"
  puts "| This is manage studentn program   |"
  puts "| 1. Add a new student              |"
  puts "| 2. List students                  |"
  puts "| 3. Find student by id_student     |"
  puts "| 4. Average mark of class          |"  
  puts "| 5. Find student has highest mark  |"
  puts "| 6. Filter students by age         |"
  puts "| 7. Delete student by id_student   |"
  puts "| 8. Exit                           |" 
  puts "-------------------------------------"
  print "Enter your choice: "
  choice = gets.chomp.to_i

  case choice 
  #2. Viết một phương thức để thêm sinh viên mới vào danh sách.
    when 1
      puts "Add a new student"
      print "Enter student id: "
      id_student = gets.chomp
      print "Enter student name: "
      name = gets.chomp
      print "Enter student age: "
      age = gets.chomp.to_i
      print "Enter student mark: "
      mark = gets.chomp.to_f

      students.push({id_student: id_student, name: name, age: age, mark: mark})
      
      puts "Add student sucessfully"
#3. Viết một phương thức để hiển thị danh sách sinh viên.
    when 2
      puts "List students"
      students.each do |student|
      puts "Student id: #{student[:id_student]}, Name: #{student[:name]}, Age: #{student[:age]}, Mark: #{student[:mark]}"
    end
#4. Viết một phương thức để tìm sinh viên theo mã sinh viên.
    when 3
      puts "Find student by id_student"
      print "Enter student id you want to find: "
      id_student = gets.chomp
      found = false
      students.each do |student| 
        if student[:id_student].downcase == id_student.downcase
          puts "Student id: #{student[:id_student]}, Name: #{student[:name]}, Age: #{student[:age]}, Mark: #{student[:mark]}"
          found = true
        end
      end    
        puts "No student found with ID: #{id_student}." unless found
#5. Viết một phương thức để tính điểm trung bình của lớp
    when 4
      puts "Average mark of class"
      sum_mark = 0
      students.each do |student|
        sum_mark += student[:mark]
      end
      average_mark = sum_mark / students.length
      puts "Average mark of this class: #{average_mark}"
#6. Viết một phương thức để tìm sinh viên có điểm cao nhất.
    when 5
      puts "Find student has highest mark"
      top_student = students[0]
      students.each do |student|
      if student[:mark] > top_student[:mark]
        top_student = student
      end
    end
    puts "Student id: #{top_student[:id_student]}, Name: #{top_student[:name]}, Age: #{top_student[:age]}, Mark: #{top_student[:mark]}"
  #cách 2  
  # when 5
  #     puts "Find student has highest mark"
  #     top_student = students.max_by { |student| student[:mark] }
  
  #      puts "Student id: #{top_student[:id_student]}, Name: #{top_student[:name]}, Age: #{top_student[:age]}, Mark: #{top_student[:mark]}"
#7.  Viết một phương thức để lọc danh sách sinh viên theo độ tuổi.
    when 6
      puts "Filter students by age"
      print "Enter age of student you want to filter: "
      age = gets.chomp.to_i
      students.each do |student|
        if (age == student[:age])
          puts "Student id: #{student[:id_student]}, Name: #{student[:name]}, Age: #{student[:age]}, Mark: #{student[:mark]}"
        end 
      end 
#8. Viết một phương thức để xóa sinh viên theo mã sinh viên.
    when 7
      puts "Delete student by id_student"
      print "Enter student id you want to delete: "
      id_student = gets.chomp
      found = false 
      students.each do |student|
        if student[:id_student].downcase == id_student.downcase
          students.delete(student)
          puts "Delete student sucessfully"
          found = true
        end
      end
      puts "Not found student has id #{id_student}"
    # #cách 2 
    # when 7
    #   puts "Delete student by id_student"
    #   print "Enter student id you want to delete: "
    #   id_student = gets.chomp
    #   found = false 

    #   for i in 0...students.length
    #     if students[i][:id_student].downcase == id_student.downcase
    #       students.delete_at(i)
    #       puts "Delete student successfully"
    #       found = true
    #     end
    #   end

    # puts "Not found student with id #{id_student}" unless found
#exit
    when 8
      puts "Good bye! See you later :)))"
    break;
    else
      puts "Invalid choice. If you want to exit Please enter 8 :>>"
    end
end while choice != 8
