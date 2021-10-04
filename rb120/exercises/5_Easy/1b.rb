# frozen_string_literal: true

# banner
class Banner
  MAX_WIDTH = 20
  MIN_WIDTH = 8
  PADDING = 4

  def initialize(message, width = nil)
    @message = message
    banner_width = calculate_width(width)
    @message_width = banner_width - PADDING
  end

  def to_s
    [horizontal_rule, empty_line, *message_line, empty_line, horizontal_rule].join("\n")
  end

  private

  attr_reader :message, :message_width

  def calculate_width(width)
    # width ||= message.length + PADDING
    # width = [width, PADDING].max unless message.empty?
    return 4 if message.empty?

    width = if width
              [width, MIN_WIDTH].max
            else
              [message.length + PADDING, MIN_WIDTH].max
            end

    [MAX_WIDTH, width].min
  end

  def horizontal_rule
    "+-#{'-' * message_width}-+"
  end

  def empty_line
    "| #{' ' * message_width} |"
  end

  def wrap_long_message
    pattern = /.{1,#{message_width}}/

    message.scan(pattern).map do |line|
      "| #{line.strip.ljust(message_width)} |"
    end
  end

  def message_line
    if message.length > message_width
      wrap_long_message
    else
      ["| #{message.ljust(message_width)} |"]
    end
  end
end

banner = Banner.new('To boldly go where no one has gone before.')
puts banner

banner = Banner.new('To boldly go where no one has gone before.', 10)
puts banner

banner = Banner.new('')
puts banner

banner = Banner.new('To boldly go where no one has gone before.', 0)
puts banner
