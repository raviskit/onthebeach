class SelfDependencyError < StandardError
  def message
    "jobs can’t depend on themselves"
  end
end
