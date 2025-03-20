class Schedule
  def initialize(title)
    @title = title
    @sessions = []
    yield self if block_given?
  end

  def add_session(subject, time, room, teacher)
    @sessions.push({ subject: subject, time: time, room: room, teacher: teacher })
  end

  def print_schedule
    puts "#{@title.upcase}"
    sorted_sessions = @sessions.sort_by { |s| extract_hour(s[:time]) }
    sorted_sessions.each do |session|
      puts "--------------------------------"
      puts "Subject: #{session[:subject]}"
      puts "Time: #{session[:time]}"
      puts "Room: #{session[:room]}"
      puts "Teacher: #{session[:teacher]}"
      puts "--------------------------------"
    end
  end

  private

  def extract_hour(time_range)
    time_range.split(" - ").first.gsub(":", "").to_i
  end
end

# Sử dụng DSL để tạo lịch học
schedule = Schedule.new("Lịch học Ruby") do |s|
  s.add_session("Ruby nâng cao", "13:00 - 15:00", "A1.02", "Trần Thị B")
  s.add_session("Ruby cơ bản", "9:00 - 11:00", "A1.01", "Nguyễn Văn A")
  s.add_session("Rails cơ bản", "15:30 - 17:30", "A1.03", "Lê Văn C")
end

# In lịch học đã sắp xếp
schedule.print_schedule
