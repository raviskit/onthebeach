class Job
  attr_accessor :value, :dependent_id

  def initialize(value, dependent_id = nil)
    @value = value
    @dependent_id = dependent_id
  end

end
