require 'singleton'

class Logger
  include Singleton

  # Private constructor to prevent direct instantiation
  private def initialize
    @log_entries = []
  end

  # Method to access the singleton instance
  def self.get_instance
    instance
  end

  # Method to add log entries
  def log(message)
    @log_entries << message
  end

  # Method to retrieve log entries
  def get_logs
    @log_entries
  end
end

# Example usage
logger1 = Logger.get_instance
logger1.log("Log entry 1")

logger2 = Logger.get_instance
logger2.log("Log entry 2")

# Both logger1 and logger2 point to the same instance
puts logger1.get_logs

puts logger1 == logger2
