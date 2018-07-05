module ApplicationHelper

  def generate_platform_url(path)
    "#{ENV.fetch('PLATFORM_ROOT_URL')}/#{path}"
  end

end
