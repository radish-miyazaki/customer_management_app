class WorkAddress < Address

  # Normalization
  before_validation do
    self.company_name = normalize_as_name(company_name)
    self.division_name = normalize_as_name(division_name)
  end

  # Validation
  validates :company_name, presence: true
end
