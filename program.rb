p "Please enter the Jobs."
p "Each job should be in newline and at the end put # to end the sequence"

$/ = '#'
jobs =  jobs = STDIN.gets.chomp("#")

job_list = JobList.new(jobs)
p "Entered jobs are: #{job_list}"
