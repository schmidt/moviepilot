class Moviepilot::Configuration
  def base_url(base_url = nil)
    @base_url = base_url if base_url
    @base_url
  end
  alias_method :base_url=, :base_url

  def api_key(api_key = nil)
    @api_key = api_key if api_key

    @api_key || warn("Please configure your moviepilot api key. " +
                     "Otherwise, it won't work")
  end
  alias_method :api_key=, :api_key
end
