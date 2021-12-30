require 'rails_helper'
describe 'Outings show page' do
  it 'I see the outings name, location and date' do
    kickball = Outing.create!(description: 'Kickball', location: 'Bali', date: '01/01/22')
    baseball = Outing.create!(description: 'Baseball', location: 'Texas', date: '01/02/22')
    visit "/outings/#{kickball.id}"
    expect(page).to have_content("Outing Name: #{kickball.description}")
    expect(page).to have_content("Location: #{kickball.location}")
    expect(page).to have_content("Date: #{kickball.date}")
    expect(page).to_not have_content(baseball.description)
  end
  it 'I see a total count of the contestants that were on this outing' do
    susan = Bachelorette.create!(name: 'Susan', season_number: 9, description: 'The best season')
    sam = Contestant.create!(name: 'Sam', age: 29, hometown: 'Denver', bachelorette_id: susan.id)
    seth = Contestant.create!(name: 'Seth', age: 29, hometown: 'Denver', bachelorette_id: susan.id)
    kickball = Outing.create!(description: 'Kickball', location: 'Bali', date: '01/01/22')
    seth_outing_1 = ContestantOuting.create!(contestant_id: seth.id, outing_id: kickball.id)
    sam_outing_1 = ContestantOuting.create!(contestant_id: sam.id, outing_id: kickball.id)
    visit "/outings/#{kickball.id}"
    expect(page).to have_content("Count of Contestants: 2")
  end

  it 'I see a list of all names of the contestants on that outing' do
    susan = Bachelorette.create!(name: 'Susan', season_number: 9, description: 'The best season')
    sam = Contestant.create!(name: 'Sam', age: 29, hometown: 'Denver', bachelorette_id: susan.id)
    seth = Contestant.create!(name: 'Seth', age: 29, hometown: 'Denver', bachelorette_id: susan.id)
    sean = Contestant.create!(name: 'Sean', age: 29, hometown: 'Denver', bachelorette_id: susan.id)
    kickball = Outing.create!(description: 'Kickball', location: 'Bali', date: '01/01/22')
    baseball = Outing.create!(description: 'Baseball', location: 'Bali', date: '01/01/22')
    seth_outing_1 = ContestantOuting.create!(contestant_id: seth.id, outing_id: kickball.id)
    sam_outing_1 = ContestantOuting.create!(contestant_id: sam.id, outing_id: kickball.id)
    sean_outing_1 = ContestantOuting.create!(contestant_id: sean.id, outing_id: baseball.id)
    visit "/outings/#{kickball.id}"
    expect(page).to have_content("Contestants: #{sam.name} #{seth.name}")
    expect(page).to_not have_content(sean.name)
  end
end
