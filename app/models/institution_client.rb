class InstitutionClient < Client
  before_save :set_is_individual

private

  def set_is_individual
    is_individual = false
  end
end
