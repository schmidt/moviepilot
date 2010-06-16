class Moviepilot::Base
  include HTTParty

  attr_reader :id

  def self.path(path = nil)
    @path = path if path
    @path
  end

  def initialize(id)
    @id = id
  end

  def method_missing(method_symbol, *args)
    method_name = method_symbol.to_s
    if attributes.has_key?(method_name)
      if args.empty?
        attributes[method_name]
      else
        raise ArgumentError, "wrong number of arguments (#{args.size} for 0)"
      end
    else
      super
    end
  end

  def respond_to?(method_name)
    super || attributes.has_key?(method_name.to_s)
  end

  def to_hash
    attributes.merge(:id => @id)
  end
  
  # todo
  def to_yaml
    super
  end

protected
  def parameters
    {}
  end

  def verify_attributes(attributes)
    if attributes.has_key?('error')
      raise Moviepilot::Exception, attributes['error']
    end
  end

private
  def attributes
    @attributes ||= begin
      url = File.join(Moviepilot.configuration.base_url, self.class.path % @id)
      params = parameters.merge('api_key' => Moviepilot.configuration.api_key)

      begin
        @attributes = self.class.get(url, :query => params)
      rescue
        raise Moviepilot::Exception.new, "Unkown error, please check Moviepilot.configuration.base_url."
      end
      @attributes
    end
    verify_attributes(@attributes)
    @attributes
  end
end
