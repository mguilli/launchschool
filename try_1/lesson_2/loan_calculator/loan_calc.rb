# Loan Payment Calculator

require 'yaml'

TERMS = YAML.load_file('data.yml')
TERM_WIDTH = 46
BOX_WIDTH = 40

# Main menu methods
def center(str, pad_char=' ', width=TERM_WIDTH)
  str.lines.map { |line| line.strip.center(width, pad_char) }.join("\n")
end

def line(msg, str)
  indent = 3
  msg << '|'.ljust(indent) + str.ljust(BOX_WIDTH - (indent + 1)) + '|' + "\n"
end

def display_loan_terms(loan)
  msg = center(TERMS[:box_output][:title], '=', 40) + "\n"

  loan.keys.each do |t|
    value_str = loan[t] ? format(TERMS[:format][t], loan[t]) : 'No Data'
    line(msg, TERMS[:box_output][t] + value_str)
  end

  msg << center('=', '=', 40) + "\n" + TERMS[:box_output][:quit]
  msg
end

def prompt
  puts 'Please enter a selection: '
  print '>> '
  gets.chomp.downcase
end

def valid_selection?(selection)
  %w(a b c d).include?(selection)
end

# Determines if there is enough data to calculate the selected term
def enough_data?(loan, term)
  x = loan.select { |k, _v| k != term }
  !x.values.include?(nil)
end

def wipe_screen
  system('cls') || system('clear')
end

# Loan term data input methods
def valid_data?(input_data, term)
  TERMS[:valid][term] =~ input_data && input_data.to_f > 0
end

def calculate_chosen?(input)
  /^c-[abcd]$/ =~ input
end

def input_term_value(loan, term)
  loop do
    puts TERMS[:input_prompt][term]
    print ">> "
    input_data = gets.chomp

    if valid_data?(input_data, term)
      loan[term] = input_data.public_send(TERMS[:convert][term])
      break
    else
      puts TERMS[:error_msg][:invalid_data]
    end
  end
  "The loan #{TERMS[:name][term]} has been updated."
end

# Loan term calculation methods
def calc_pmt(loan)
  rate = (loan[:apr] / 100) / 12
  payment = loan[:amt] * (rate / (1 - (1 + rate)**(-loan[:length])))
  loan[:pmt] = payment.round(2)
  TERMS[:message][:pmt]
end

def calc_amt(loan)
  rate = (loan[:apr] / 100) / 12
  amount = loan[:pmt] / (rate / (1 - (1 + rate)**(-loan[:length])))
  loan[:amt] = amount.round(2)
  TERMS[:message][:amt]
end

def calc_length(loan)
  rate = (loan[:apr] / 100) / 12
  numerator = -Math.log(1 - rate * loan[:amt] / loan[:pmt])
  length = (numerator / Math.log(1 + rate)).ceil(2)
  loan[:length] = length.round(2)
  TERMS[:message][:length]
end

def calc_apr(loan)
  pmt = loan[:pmt]
  length = loan[:length]
  amt = loan[:amt]
  rate = (100.00 / 100) / 12 # APR guess of 30% converted to monthly rate

  # Newton-Rhapson iterative method to find monthly interest to 6 decimal places
  loop do
    numerator = (pmt - (pmt * (1 + rate)**-length) - (rate * amt))
    denominator = (length * pmt * (1 + rate)**(-length - 1)) - amt
    new_rate = rate - (numerator / denominator)

    break if new_rate.round(6) == rate.round(6)
    rate = new_rate
  end

  if rate.round(6) > 0
    loan[:apr] = (rate * 12 * 100).round(6)
    TERMS[:message][:apr]
  else
    TERMS[:error_msg][:apr_error]
  end
end

# Begin main program

loan = { amt: nil, apr: nil, length: nil, pmt: nil }
continue = true
msg = ''

while continue == true
  wipe_screen
  puts center(TERMS[:message][:title], '*')
  puts
  puts center(TERMS[:message][:instructions])
  puts center(display_loan_terms(loan))

  loop do
    puts center(msg)
    selection = prompt()

    # Selection validation and routing
    case
    when selection.start_with?('q')
      puts center(TERMS[:message][:exit], '*')
      continue = false
      break
    when calculate_chosen?(selection)
      term = TERMS[:options][selection[-1]]
      msg =
        if enough_data?(loan, term)
          send("calc_#{term}", loan)
        else
          TERMS[:error_msg][:not_enough_data]
        end
      break
    when valid_selection?(selection) # move to input data methods
      term = TERMS[:options][selection]
      msg = input_term_value(loan, term)

      # Alert user to run new calculation when term values do not reconcile.
      if enough_data?(loan, term)
        msg += TERMS[:error_msg][:recalc]
      end

      break
    else
      msg = TERMS[:error_msg][:invalid_selection]
      next
    end
  end
end
