class FlexLogger
  LEVELS = [:debug, :info, :warn, :error]
  
  def initialize
    @handlers = {}
  end

  def add_handler(name, filter: nil, formatter: nil, &block)
    @handlers[name] = { handler: block, filter: filter, formatter: formatter }
  end

  LEVELS.each do |level|
    define_method(level) do |message|
      log(level, message)
    end
  end

  private

  def log(level, message)
    @handlers.each_value do |config|
      next if config[:filter] && !config[:filter].call(message, level)
      formatted_message = config[:formatter] ? config[:formatter].call(message, level) : "[#{level.upcase}] #{message}"
      config[:handler].call(formatted_message, level)
    end
  end
end

# Khởi tạo logger
logger = FlexLogger.new

# Thêm console handler
logger.add_handler("console") do |message, level|
  puts message
end

# Thêm file handler chỉ ghi lỗi với định dạng có timestamp
only_errors = ->(message, level) { level == :error }
timestamp_format = Proc.new { |msg, lvl| "#{Time.now} [#{lvl.upcase}] #{msg}" }

logger.add_handler("file", filter: only_errors, formatter: timestamp_format) do |message, level|
  File.open("error.log", "a") { |file| file.puts message }
end

# Ghi log
logger.debug "Đây là debug message"
logger.info "Ứng dụng đã khởi động"
logger.warn "Cảnh báo: Disk space thấp"
logger.error "Lỗi kết nối database!"
