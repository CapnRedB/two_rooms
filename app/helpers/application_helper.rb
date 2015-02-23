module ApplicationHelper

  def markdown(text)
    $markdown.render(text).html_safe
  end
  
end
