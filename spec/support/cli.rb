class UserInput
  def initialize(commands = nil)
    @commands = Array(commands)
  end

  def chomp
    @commands.shift || 'exit'
  end
end

def capture(type = :stdout, &block)
  original_stdout, original_stderr = $stdout, $stderr
  $stdout = fake_out = StringIO.new
  $stderr = fake_err = StringIO.new

  begin
    yield
  ensure
    $stdout, @stderr = original_stdout, original_stderr
  end

  case type
  when :stdout
    fake_out.string
  when :stderr
    fake_err.string
  end
end
