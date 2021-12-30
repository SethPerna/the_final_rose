require 'rails_helper'
describe 'Contestants show page' do
  it 'I see the contestants name as well as the season they were on and description' do
    susan = Bachelorette.create!(name: 'Susan', season_number: 9, description: 'The best season')
    seth = Contestant.create!(name: 'Seth', age: 29, hometown: 'Denver', bachelorette_id: susan.id)
    visit "contestants/#{seth.id}"
    expect(page).to have_content("#{seth.name}")
    expect(page).to have_content("#{susan.season_number}")
    expect(page).to have_content("#{susan.description}")
  end

  it 'I see a list of the outings that contestant has been on' do
    susan = Bachelorette.create!(name: 'Susan', season_number: 9, description: 'The best season')
    seth = Contestant.create!(name: 'Seth', age: 29, hometown: 'Denver', bachelorette_id: susan.id)
    kickball = Outing.create!(description: 'Kickball', location: 'Bali', date: '01/01/22')
    baseball = Outing.create!(description: 'Baseball', location: 'Texas', date: '01/02/22')
    seth_outing_1 = ContestantOuting.create!(contestant_id: seth.id, outing_id: kickball.id)
    seth_outing_2 = ContestantOuting.create!(contestant_id: seth.id, outing_id: baseball.id)
    visit "/contestants/#{seth.id}"
    expect(page).to have_content("Outings: #{kickball.description} #{baseball.description}")
    expect(page).to have_link("#{kickball.description}")
    expect(page).to have_link("#{baseball.description}")
    click_link("#{kickball.description}")
    expect(current_path).to eq("/outings/#{kickball.id}")
  end
end
