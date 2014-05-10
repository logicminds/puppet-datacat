Puppet::Parser::Functions::newfunction(:template_body, :type => :rvalue, :doc => <<-'ENDOFDOC'

Takes a string or array of template(s) and concats the contents of each template to a string
If passing in an array or string array, the ordering of each template matters as they will
be processed in order.

example:
   template_body('demo/demo1.erb')
   template_body(['demo/demo1.erb', 'demo/demo2.erb', 'demo/demo3.erb'])  Array
   template_body('demo/demo1.erb, demo/demo2.erb, demo/demo3.erb')       String Array



ENDOFDOC
) do |args|
  raise(Puppet::ParseError, "function_template_body: empty arguments given #{args.inspect}" ) if args.size < 1
  data = args[0]
  raise(Puppet::ParseError, "function_template_body: empty arguments given #{args.inspect}" ) if args.empty?

  if data.instance_of?(Array) and data.size < 1
    raise(Puppet::ParseError, "function_template_body: empty arguments given #{data.inspect}" )
  end

  case data.class.to_s
    when 'Array'
      templates = data
    when 'String'
      # maybes its a array in a string
      templates = data.split(',')
    else
      raise(Puppet::ParseError, "function_template_body: Invalid template array or string: #{data}")
  end
  templates.collect do |file|
    file = file.strip
    unless filename = Puppet::Parser::Files.find_template(file, self.compiler.environment)
      raise Puppet::ParseError, "function_template_body: Could not find template #{file}"
    end
    File.read(filename)
  end.join('')
end
