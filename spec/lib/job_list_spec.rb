require 'spec_helper'
describe "JobList" do


  it "should return an empty sequence when no jobs are passed" do
    job_list = JobList.new('')
    expect(job_list.jobs).to eq('')
  end

  it "should return a single job sequence when a single job is passed" do
    job_list = JobList.new('a=>')
    expect(job_list.jobs).to eq('a=>')
  end

  it "should return a jobs sequence in no significant order when more than one jobs is passed" do
    job_list = JobList.new('a=>\nb=>')
    expect(job_list.jobs).to eq('a=>\nb=>')
  end

  it "should return a jobs sequence in order when jobs are dependent of each other" do
  end

  it "should return a jobs sequence in order when jobs are dependent of other jobs" do
  end

  it "should return an error when job is dependent on itself" do
  end

  it "should return an error when there is a circular dependency on jobs" do
  end

end
