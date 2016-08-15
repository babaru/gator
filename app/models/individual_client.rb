class IndividualClient < Client
  before_save :set_is_individual

private

  def set_is_individual
    is_individual = true
  end
end
