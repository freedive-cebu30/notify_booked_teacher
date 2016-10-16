module TeachersHelper
  def display_active_li(current_action_name, target_action_name)
    tag =
      if current_action_name == target_action_name
        '<li class="active">'
      else
        '<li>'
      end
    tag.html_safe
  end
end
