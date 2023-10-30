require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'

def clean_phone_number(number)
  number.gsub(/[^0-9]/, '')

  if number.length < 10 || number.length > 10
    number = nil
  elsif number.length == 10
    number
  elsif number.length == 11 && number[0] == 1
    number.slice!(0)
  elsif number.length > 10 && number[0] != 1
    number = nil
  else
    number
  end
end


def open_csv
  CSV.open(
    'event_attendees.csv',
    headers: true,
    header_converters: :symbol
  )

end

def calculate_peak_day
  contents = open_csv
  days = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday']
  week_array = []
  contents.each do |row|
  regdate = row[:regdate]
  reg_day = DateTime.strptime(regdate, '%m/%d/%y').wday
  week_array.push(reg_day)
end

peak_day = week_array.max_by { |day| week_array.count(day)}
peak_day_name = days[peak_day]

end

def calculate_peak_hour
  contents = open_csv
  hours_array = []
  contents.each do |row|
    regdate = row[:regdate]
    reg_hour =  DateTime.strptime(regdate, '%m/%d/%y %H:%M').hour
    hours_array.push(reg_hour)
  end

  peak_hour = hours_array.max_by { |hour| hours_array.count(hour)}
  peak_hour

  end
  


def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5,"0")[0..4]
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
peak_hour = calculate_peak_hour
peak_day_name = calculate_peak_day
puts "\n The peak registration hour is #{peak_hour} hours"
puts "\n The peak registration day of the week is #{peak_day_name}"


template_letter = File.read('form_letter.erb')
erb_template = ERB.new template_letter

contents = open_csv
contents.each do |row|
  id = row[0]
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])
  legislators = legislators_by_zipcode(zipcode)
  phone_number = clean_phone_number(row[:homephone])
  form_letter = erb_template.result(binding)

  save_thank_you_letter(id,form_letter)
end