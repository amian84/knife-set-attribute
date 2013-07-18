class SetAttribute < Chef::Knife
  deps do
    require 'chef/api_client'
    require 'chef'
    require 'chef/node'
    require 'optparse'
  end

  banner "knife set_attribute NODE ATTRIBUTE VALUE (options)"

  option :separator,
    :long => "--separator SEPARATOR",
    :description => "Attribute dimension separator, defaults to '.'",
    :default => "."

  def run
    unless name_args.length >= 3
      show_usage
      exit 1
    else
      @nodename = @name_args[0]
      attribute_arg = @name_args[1]
      new_value = @name_args[2]
    end
    
    @nodelist = Chef::Node.list().map { |n| n.first }.select { |key, value| key =~ Regexp.new("^#{@nodename}$") }.sort

    unless @nodelist.empty?
      puts "Updating nodes: #{@nodelist.join(',')}"
      @nodelist.each do |n|
        node = Chef::Node.load(n)
        slices = attribute_arg.split(config[:separator])
        last = slices.pop
        parts = slices
        hash = parts.inject(node.normal) { |h,attr| !h.has_key?(attr) ? (h[attr]={}; h[attr]) : h[attr]}
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
        node.save
        puts "#{n} has been updated"
      end
    else
      puts "Found no matching nodes"
      exit 1
    end
  end
end

