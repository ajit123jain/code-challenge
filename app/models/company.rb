class Company < ApplicationRecord
  include ActiveModel::Validations
  has_rich_text :description

  after_validation :set_city_state, on: [ :create, :update ], if: -> { zip_code.present? && zip_code_changed? }
  validates :email, email: true, if: -> { email.present? }
  validates :zip_code, presence: true, format: { with: /[0-9]{5}/, message: 'The zip code should consist of 5 digits.'}
  validates :name, presence: true

  def get_city_state 
    return (city.present? && state.present?) ? "#{city}, #{state}" : "-"
  end
  
  private 
  def set_city_state 
    zipcode_data = ZipCodes.identify(zip_code) 
    return if zipcode_data.blank?
    self.city = zipcode_data[:city].present? ? zipcode_data[:city] : nil
    self.state = zipcode_data[:state_code].present? ? zipcode_data[:state_code] : nil
  end
end
