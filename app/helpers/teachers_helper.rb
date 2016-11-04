module TeachersHelper
  def display_active_li(current_action_name, target_action_name)
    tag =
      if ( controller.controller_name == 'sessions' ) ||
         ( controller.controller_name == 'passwords' ) ||
         ( controller.controller_name == 'registrations' ) ||
         ( controller.controller_name ==  'confirmations' ) ||
         ( controller.controller_name ==  'introductions' )
        '<li>'
      elsif current_action_name == target_action_name
        '<li class="active">'
      else
        '<li>'
      end
    tag.html_safe
  end
end
