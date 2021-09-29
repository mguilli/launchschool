# frozen_string_literal: true

# Medium 2 - unlucky days
require 'date'

def friday_13th(year)
  (1..12).select { |month| Date.new(year, month, 13).friday? }.size
end

puts friday_13th(2015) == 3
puts friday_13th(1986) == 1
puts friday_13th(2019) == 2

def five_fridays_old(year)
  start_of_year = Date.new(year)
  months_with_five_fridays = 0

  12.times do |n|
    start_of_month = start_of_year.next_month(n)
    end_of_month = start_of_month.next_month.prev_day

    fridays = (start_of_month..end_of_month).count(&:friday?)
    months_with_five_fridays += 1 if fridays >= 5
  end

  months_with_five_fridays
end

def five_fridays_second(year)
  (1..12).map do |month|
    first = Date.new(year, month)
    last = first.next_month.prev_day

    (first..last).count(&:friday?)
  end.count { |fridays| fridays >= 5 }
end

def five_fridays(year)
  dates = (Date.new(year)..Date.new(year, 12, 31)).select(&:friday?)
  dates.count { |date| date.day > 28 }
end

puts five_fridays(2021) == 5
puts five_fridays(2020) == 4
