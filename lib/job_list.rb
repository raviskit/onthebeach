require_relative './job'
class JobList
  	attr_accessor :jobs

    def initialize(jobs)
      @jobs = jobs_processor(jobs)
    end

    def jobs_processor(jobs_sequence)
      return [] if jobs_sequence.empty?

      jobs = jobs_sequence.split("\n")

      @final_jobs = []
      jobs.each do |job|
        job_with_dependent = job.split('=>').map{|i| i.strip}
        @final_jobs << Job.new(job_with_dependent[0], job_with_dependent[1])
      end

      @final_jobs
    end

    def jobs
      return "" if @jobs.length == 0
      @jobs.collect { |job| job.value }.join("")
    end
end
