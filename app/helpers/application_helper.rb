module ApplicationHelper
  def flash_message_color(type)
    case type.to_sym
    when :notice then "bg-green-200 text-green-600"
    when :alert  then "bg-red-200 text-red-600"
    else "bg-gray-200 text-gray-600"
    end
  end
end
