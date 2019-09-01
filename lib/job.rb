require_relative "./exceptions/self_dependency_error"

class Job
  attr_accessor :value, :dependent_id

  def initialize(value, dependent_id = nil)
    raise SelfDependencyError if value == dependent_id

    @value = value
    @dependent_id = dependent_id
  end
end
