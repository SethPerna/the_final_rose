require 'rails_helper'

RSpec.describe Outing, type: :model do
  describe 'relationships' do
    it {should have_many :contestant_outings}
    it {should have_many(:contestants).through(:contestant_outings)}
  end

  it 'counts all contestants on an outing' do
    susan = Bachelorette.create!(name: 'Susan', season_number: 9, description: 'The best season')
    sam = Contestant.create!(name: 'Sam', age: 29, hometown: 'Denver', bachelorette_id: susan.id)
    seth = Contestant.create!(name: 'Seth', age: 29, hometown: 'Denver', bachelorette_id: susan.id)
    kickball = Outing.create!(description: 'Kickball', location: 'Bali', date: '01/01/22')
    seth_outing_1 = ContestantOuting.create!(contestant_id: seth.id, outing_id: kickball.id)
    sam_outing_1 = ContestantOuting.create!(contestant_id: sam.id, outing_id: kickball.id)
    expect(kickball.count_contestants).to eq(2)
  end
end
