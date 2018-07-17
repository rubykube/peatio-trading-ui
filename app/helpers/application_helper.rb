module ApplicationHelper

  def generate_ui_url(path)
    "#{ENV.fetch('FRONTEND_ROOT_URL')}/#{path}"
  end

end
