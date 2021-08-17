# test file

require 'pry'
require 'yaml'

TERMS = YAML.load_file("/home/ubuntu/code/launch/lesson_2/data.yml")


WIDTH = 46
BOX = 40

loan = { amt: 2, apr: nil, length: 12, pmt: nil }

def center(str, pad=' ', wide=WIDTH)
  str.lines.map { |line| line.strip.center(wide,pad) }.join("\n")
  # binding.pry
end

def line(msg, str)
  indent = 3
  msg << '|'.ljust(indent) + str.ljust(BOX - (indent + 1)) + '|' + "\n"
end

def display_loan_terms(loan)
  msg = center(TERMS[:box_output][:title], '=', 40) + "\n"

  loan.keys.each do |key|
    value_str = loan[key] ? format(TERMS[:format][key],loan[key]) : 'No Data'
    line(msg, TERMS[:box_output][key] + value_str)
  end

  msg << center('=', '=', 40)
  return msg
end

puts center(display_loan_terms(loan))