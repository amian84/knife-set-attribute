class SetAttribute < Chef::Knife
  deps do
    require 'chef/api_client'
    require 'chef'
    require 'chef/node'
  end

  banner "knife set_attribute [NODE] [ATTRIBUTE] [VALUE]"

  def run
    unless name_args.length == 3
      show_usage
      exit 1
    else
      @nodename = @name_args[0]
      attribute_arg = @name_args[1]
      new_value = @name_args[2]
    end
    @node = Chef::Node.load(@nodename)
    slices = attribute_arg.split('.')
    last = slices.pop
    parts = slices
    hash = parts.inject(@node) { |h,attr| !h.has_key?(attr) ? (h[attr]={}; h[attr]) : h[attr]}
    if new_value.start_with?('[') and new_value.end_with?(']')
      prev = eval(new_value)
      new_arr = []
      prev.each do |x|
        new_arr << eval(x)
      end
      hash[last] = new_arr
    else
      hash[last] = new_value
    end

    @node.save
  end
end

