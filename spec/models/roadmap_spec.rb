require "spec_helper"

describe Roadmap do
  it 'have a valid generator' do
    Roadmap.make!.should be_valid
  end

  it 'have product' do
    Roadmap.make(:product => nil).should_not be_valid
  end

  it 'have machines' do
    Roadmap.make(:machines => []).should_not be_valid
  end
end

