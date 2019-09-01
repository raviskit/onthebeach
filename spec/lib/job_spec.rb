require 'spec_helper'

describe 'Job' do

  it 'should have a value' do
    job = Job.new('a')
    expect(job.value).to eq('a')
  end

  it 'can have a value and dependent_id' do
    job = Job.new('a', 'b')
    expect(job.value).to eq('a')
    expect(job.dependent_id).to eq("b")
  end

  it 'should have an option dependent_id and not option value' do
    expect{Job.new()}.to raise_error ArgumentError
    expect { Job.new("a") }.not_to raise_error
  end

  it "should return an self dependency error when job is dependent on itself" do
    expect{Job.new("a", "a")}.to raise_error(SelfDependencyError)
  end

end
