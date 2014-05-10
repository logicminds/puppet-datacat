require 'spec_helper'

describe 'template_body' do
  it { should run.with_params().and_raise_error(Puppet::ParseError) }
  it { should run.with_params([]).and_raise_error(Puppet::ParseError) }

  it { should run.with_params('template_body/really_should_never_exist.erb').and_raise_error(Puppet::ParseError) }
  it { should run.with_params('template_body/test1.erb').and_return("Goodbye cruel world\n") }

  # describe 'multi templates using array' do
  #   it { should run.with_params(['template_body/really_should_never_exist.erb']).
  #                 and_raise_error(Puppet::ParseError) }
  #   it { should run.with_params(['template_body/test1.erb', 'template_body/test2.erb']).and_return("Goodbye cruel world\nroar!") }
  # end

  # describe 'multi templates using string array' do
  #   it { should run.with_params('template_body/really_should_never_exist.erb, template_body/never_exist2.erb').
  #                 and_raise_error(Puppet::ParseError) }
  #   it { should run.with_params('template_body/test1.erb, template_body/test2.erb').and_return("Goodbye cruel world\nroar!") }
  # end

end
