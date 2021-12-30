require 'rails_helper'

RSpec.describe Bachelorette, type: :model do
  describe 'relationships' do
    it {should have_many :contestants}
  end

  it 'averages the age of contestants' do
    susan = Bachelorette.create!(name: 'Susan', season_number: 9, description: 'The best season')
    beth = Bachelorette.create!(name: 'Beth', season_number: 8, description: 'The worst season')
    sean = susan.contestants.create!(name: 'Sean', age: 32, hometown: 'Denver')
    sam = susan.contestants.create!(name: 'Sam', age: 30, hometown: 'Denver')
    seth = beth.contestants.create!(name: 'Seth', age: 29, hometown: 'Denver')
    expect(susan.average_age).to eq(31)
  end

  it 'gives a unique list of hometowns' do
    susan = Bachelorette.create!(name: 'Susan', season_number: 9, description: 'The best season')
    beth = Bachelorette.create!(name: 'Beth', season_number: 8, description: 'The worst season')
    sean = susan.contestants.create!(name: 'Sean', age: 31, hometown: 'Denver')
    sam = susan.contestants.create!(name: 'Sam', age: 30, hometown: 'DC')
    seth = susan.contestants.create!(name: 'Seth', age: 29, hometown: 'Denver')
    expect(susan.unique_hometowns).to eq(["DC", "Denver"])
  end
end
