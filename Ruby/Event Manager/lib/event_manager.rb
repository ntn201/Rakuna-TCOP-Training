require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5,"0")[0..4]
end

def most_freq_hour(reg_time)
  hours = reg_time.map {|time_str| Time.strptime(time_str,"%m/%d/%y %k:%M").hour}
  freq = hours.reduce(Hash.new(0)) do |hour, time| 
    hour[time.to_s] += 1
    hour
  end
  hours.max_by { |hour| freq[hour] }
end

def most_freq_day(reg_time)
  dates = reg_time.map! {|time_str| Date::DAYNAMES[Date.strptime(time_str,"%m/%d/%y %k:%M").wday]}
  freq = dates.reduce(Hash.new(0)) do |dates, day| 
    dates[day.to_s] += 1
    dates
  end
  dates.max_by { |day| freq[day] }
end

def extract_digit_frome_phone(phone_number)
  digits = phone_number.split("").reduce(Array.new) do |digits, char|
    if char.match?(/[0-9]/)
      digits.push(char)
    end
    digits
  end
  digits
end

def clean_phone_number(phone_number)
  digits = extract_digit_frome_phone(phone_number)
  if digits.length == 10
    digits.join
  elsif digits.length == 11
    if digits[0] == "1"
      digits.shift
      digits.join
    else
      "Invalid phone number"
    end
  else
    "Invalid phone number"
  end
end


def legislators_by_zipcode(zip)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

  begin
    civic_info.representative_info_by_address(
      address: zip,
      levels: 'country',
      roles: ['legislatorUpperBody', 'legislatorLowerBody']
    ).officials
  rescue
    'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
  end
end

def save_thank_you_letter(id,form_letter)
  Dir.mkdir('output') unless Dir.exist?('output')

  filename = "output/thanks_#{id}.html"

  File.open(filename, 'w') do |file|
    file.puts form_letter
  end
end

puts 'EventManager initialized.'

contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
)

contents.each do |row|
  puts clean_phone_number(row[:homephone])
end

reg_time = CSV.foreach("event_attendees.csv").map{ |row| row[1] }
reg_time.shift

puts most_freq_hour(reg_time)
puts most_freq_day(reg_time)



# template_letter = File.read('form_letter.erb')
# erb_template = ERB.new template_letter

# contents.each do |row|
#   id = row[0]
#   name = row[:first_name]
#   zipcode = clean_zipcode(row[:zipcode])
#   legislators = legislators_by_zipcode(zipcode)

#   form_letter = erb_template.result(binding)

#   save_thank_you_letter(id,form_letter)
# end