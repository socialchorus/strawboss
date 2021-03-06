require 'spec_helper'

describe Cumuli::CLI::Terminal do
  it "clears environmental variables" do
    preserving_env do
      ENV['GEM_HOME'] = 'somewhere-over-the-rainbow'

      terminal = Cumuli::CLI::Terminal.new('$GEM_HOME')
      terminal.clear_env

      ENV['GEM_HOME'].should == nil
    end
  end

  # TODO: this generates lots of noise when it is killed
  it "spawns a new thread that runs the command" do
    preserving_env do
      pid = fork do
        Cumuli::CLI::Terminal.new('CUMULI=true').spawn
        ENV['CUMULI'].should == true
      end

      Process.kill('INT', pid)
    end
  end
end
