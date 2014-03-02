require 'spec_helper'

describe "A" do
  before { puts "before A" }
  it { puts "it A1" }
  it { puts "it A2" }

  describe "B" do
    before { puts "\tbefore B" }
    it { puts "\tit B1" }
    it { puts "\tit B2" }

    describe "C" do
      before { puts "\t\tbefore C" }
      it { puts "\t\tit C1" }
      it { puts "\t\tit C2" }
    end
  end
end
