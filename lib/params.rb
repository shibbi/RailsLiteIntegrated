require 'uri'

class Params
  # use your initialize to merge params from
  # 1. query string
  # 2. post body
  # 3. route params
  #
  # You haven't done routing yet; but assume route params will be
  # passed in as a hash to `Params.new` as below:
  def initialize(req, route_params = {})
    query_params = parse_www_encoded_form(req.query_string)
    body_params = parse_www_encoded_form(req.body)
    @params = route_params.merge(query_params).merge(body_params)
  end

  def [](key)
    raise AttributeNotFoundError unless @params.keys.include?(key)
    @params[key]
  end

  def to_s
    @params.to_json.to_s
  end

  class AttributeNotFoundError < ArgumentError; end;

  private
  # this should return deeply nested hash
  # argument format
  # user[address][street]=main&user[address][zip]=89436
  # should return
  # { "user" => { "address" => { "street" => "main", "zip" => "89436" } } }
  def parse_www_encoded_form(www_encoded_form)
    www_encoded_form = '' if www_encoded_form.nil?
    params = {}
    URI::decode_www_form(www_encoded_form).each do |element|
      keys, value = element
      parsed_keys = parse_key(keys)
      current_node = params
      parsed_keys.each_with_index do |key, level|
        if level == parsed_keys.length - 1
          current_node[key] = value
        else
          current_node[key] = {} unless current_node[key].is_a?(Hash)
          current_node = current_node[key]
        end
      end
    end

    params
  end

  # this should return an array
  # user[address][street] should return ['user', 'address', 'street']
  def parse_key(key)
    key.split(/\]\[|\[|\]/).map(&:to_sym)
  end
end
