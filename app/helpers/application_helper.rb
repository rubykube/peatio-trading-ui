module ApplicationHelper

  def generate_ui_url(path)
    "#{ENV.fetch('UI_ROOT_URL')}/#{path}"
  end

end
