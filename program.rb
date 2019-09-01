require './lib/job_list'
p "Please enter the Jobs."
p "Each job should be in newline and at the end put # to end the sequence"

$/ = '#'
jobs =  jobs = STDIN.gets.chomp("#")

job_list = JobList.new(jobs)
p "Returned sequence is : #{job_list.jobs}"
