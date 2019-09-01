class CircularDependencyError < StandardError
  def message
    "jobs can’t have circular dependencies"
  end
end
