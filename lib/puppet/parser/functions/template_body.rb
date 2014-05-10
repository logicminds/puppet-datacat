Puppet::Parser::Functions::newfunction(:template_body, :type => :rvalue) do |args|
  case args[0].class.to_s
    when 'Array'
      templates = args[0]
    when 'String'
      # maybes its a array in a string
      templates = args[0].split(',')
    else
      raise(Puppet::ParseError, "function_template_body: Invalid template array or string: #{args[0]}")
  end

  templates.collect do |file|
    unless filename = Puppet::Parser::Files.find_template(file, self.compiler.environment)
      raise Puppet::ParseError, "function_template_body: Could not find template #{file} '#{filename}'"
    end
    File.read(filename)
  end.join('')
end
