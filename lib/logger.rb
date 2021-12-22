# frozen_string_literal: true

module Logger
  def log(name, val)
    return unless ENV['LOG']

    puts
    puts "log | #{name}: #{val}"
    puts
  end
end
