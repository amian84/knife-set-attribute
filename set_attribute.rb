class SetAttribute < Chef::Knife
  deps do
    require 'chef/api_client'
    require 'chef'
    require 'chef/node'
    require 'chef/role'
  end

  banner "knife set_attribute node|role [NODENAME OR ROLENAME] [ATTRIBUTE] [VALUE]"

  def run
    unless name_args.length == 4
      show_usage
      exit 1
    else
      @name = @name_args[1]
      attribute_arg = @name_args[2]
      new_value = @name_args[3]
      if @name_args[0] == 'node'
        type = 'node'
      elsif @name_args[0] == 'role'
        type = 'role'

      end        
    end

    if type == 'node'
      @obj = Chef::Node.load(@name)
    elsif type == 'role'
      @obj = Chef::Role.load(@name)
    end

    slices = attribute_arg.split('.')
    last = slices.pop
    parts = slices

    if type == 'node'
      hash = parts.inject(@obj.normal) { |h,attr| !h.has_key?(attr) ? (h[attr]={}; h[attr]) : h[attr]}
    elsif type == 'role'
      hash = parts.inject(@obj.override_attributes) { |h,attr| !h.has_key?(attr) ? (h[attr]={}; h[attr]) : h[attr]}
    end

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

    @obj.save
  end
end
