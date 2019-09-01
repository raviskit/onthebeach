require_relative './job'
require_relative "./exceptions/self_dependency_error"
require_relative "./exceptions/circular_dependency_error"

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

      jobs_with_dependancy = @final_jobs.select { |job| !job.dependent_id.nil? }

      jobs_with_dependancy.each do |dependent_job|
        dependency_index = @final_jobs.find_index { |job| dependent_job.dependent_id == job.value }
        dependent_index = @final_jobs.find_index { |job| dependent_job.value == job.value }
        @final_jobs.insert(dependent_index, @final_jobs.delete_at(dependency_index))
      end

      @final_jobs
    rescue SelfDependencyError => e
      puts e.message
    end

    def jobs
      return "" if @jobs.length == 0
      @jobs.collect { |job| job.value }.join("")
    end
end
