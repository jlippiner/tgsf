def comma_numbers(number, delimiter = ',')
  number.to_s.reverse.gsub(%r{([0-9]{3}(?=([0-9])))}, "\\1#{delimiter}").reverse
end

def is_date?(date)
  begin
    Date.parse(date)
    true
  rescue
    false
  end
end
