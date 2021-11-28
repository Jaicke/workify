module ApplicationHelper
  def format_phone(number)
    "(#{number[0,2]}) #{number[3]} #{number[3,4]}-#{number[7,10]}"
  end
end
