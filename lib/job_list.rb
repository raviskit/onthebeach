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

      check_for_circular_dependancies(@final_jobs.reject { |job| job.dependent_id.nil? })

      @final_jobs = order_jobs(@final_jobs)
    rescue SelfDependencyError, CircularDependencyError => e
      puts e.message
      abort
    end

    def jobs
		  @jobs.empty? ? "" : @jobs.collect { |job| job.value }.join("")
    end

    private

    def order_jobs(jobs)
      jobs_with_dependancy = jobs.select { |job| !job.dependent_id.nil? }

      jobs_with_dependancy.each do |dependent_job|
        dependency_index = jobs.find_index { |job| dependent_job.dependent_id == job.value }
        dependent_index = jobs.find_index { |job| dependent_job.value == job.value }
        jobs.insert(dependent_index, jobs.delete_at(dependency_index)) if dependency_index > dependent_index
      end
      jobs
    end

    def check_for_circular_dependancies(jobs)
      job_with_dependancy = Hash.new

      jobs.each do |job|
        x_id = recursive_find(job_with_dependancy, job.value)
        y_id = recursive_find(job_with_dependancy, job.dependent_id)

        raise CircularDependencyError, "Circular dependancy detected" if x_id == y_id

        # no circular dependancy so add dependancy to job for next cycle check
        job_with_dependancy[x_id] = y_id
      end
    end

    def recursive_find(job_with_dependancy, id)
      return id if job_with_dependancy[id].nil? # returns id if no dependancy for that job yet
      recursive_find(job_with_dependancy, job_with_dependancy[id]) # if there is a dependancy we recursivley find the dependancies depandancy
    end
end
