class Address < ApplicationRecord
  validates_presence_of :zip_code, :street, :neighborhood, :city, :uf, :citizen

  belongs_to :citizen

  def self.ransackable_attributes(_auth_object = nil)
    %w[citizen_id city created_at ibge_code id neighborhood street uf
       complement updated_at zip_code]
  end
end
