class Bachelorette <ApplicationRecord
  has_many :contestants

  def average_age
    contestants.average(:age)
  end

  def unique_hometowns
    contestants.distinct.pluck(:hometown)
  end
end
