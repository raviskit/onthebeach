require 'spec_helper'
describe "JobList" do


  it "should return an empty sequence when no jobs are passed" do
    job_list = JobList.new('')
    expect(job_list.jobs).to eq('')
  end

  it "should return a single job sequence when a single job is passed" do
    job_list = JobList.new('a=>')
    expect(job_list.jobs).to eq('a')
  end

  it "should return a jobs sequence in no significant order when more than one jobs is passed" do
    job_list = JobList.new("a=>\nb=>\nc=>\n")
    expect(job_list.jobs).to eq('abc')
  end

  it "should return a jobs sequence in order when jobs are dependent of each other" do
    job_list = JobList.new("a =>\nb => c\nc =>\n")
		expect(job_list.jobs).to eql "acb"
  end

  it "should return a jobs sequence in order when jobs are dependent of more than one jobs" do
    job_list = JobList.new("a =>\nb => c\nc => f\nd => a\ne => b\nf =>\n")
		expect(job_list.jobs).to eql "afcbde"
  end

  it "should return an error when there is a circular dependency on jobs" do
  end

end
