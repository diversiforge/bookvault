module ApplicationHelper
  def errors_for(model)
    if model.errors.any?
      output = '<ul>'.html_safe
      model.errors.full_messages.each do |m|
        output << "<li>#{m}</li>".html_safe
      end
      output << '</ul>'.html_safe
    end
  end
end
