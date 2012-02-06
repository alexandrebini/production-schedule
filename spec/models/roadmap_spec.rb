require "spec_helper"

describe Roadmap do
  it 'have a valid generator' do
    Fabricate(:roadmap).should be_valid
  end

  it 'have product' do
    Fabricate.build(:roadmap, :product => nil).should_not be_valid
  end

  it 'have machines' do
    Fabricate.build(:roadmap, :machines => []).should_not be_valid
  end
end