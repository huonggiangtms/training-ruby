module Retryable
  def with_retry(max_attempts:, wait_time:, on_retry: nil, on_error: nil, on_success: nil)
    attempts = 0

    begin
      attempts += 1
      result = yield
      on_success.call(result) if on_success
      return result
    rescue => e
      if attempts < max_attempts
        on_retry.call(attempts, e) if on_retry
        sleep wait_time
        retry
      else
        on_error.call(e) if on_error
        raise e
      end
    end
  end
end

include Retryable

on_retry_proc = Proc.new { |attempt, exception| puts "Retry lần #{attempt} sau lỗi: #{exception.message}" }
on_error_proc = Proc.new { |exception| puts "Thất bại sau tất cả các lần thử! Lỗi: #{exception.message}" }
on_success_proc = Proc.new { |result| puts "Thành công! Kết quả: #{result}" }

result = with_retry(
  max_attempts: 3,
  wait_time: 1,
  on_retry: on_retry_proc,
  on_error: on_error_proc,
  on_success: on_success_proc
) do
  # Giả lập một API call không ổn định
  random = rand(10)
  if random < 7
    raise "Connection timeout"
  end
  "Dữ liệu từ API"
end

puts "Kết quả cuối cùng: #{result}"
