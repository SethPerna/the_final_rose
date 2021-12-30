require 'rails_helper'
describe 'bachelorette show page' do
  it 'I see that bachelorettes name, season number and description of the season' do
    susan = Bachelorette.create!(name: 'Susan', season_number: 9, description: 'The best season')
    beth = Bachelorette.create!(name: 'Beth', season_number: 8, description: 'The worst season')
    visit "/bachelorettes/#{susan.id}"
    expect(page).to have_content("Name: #{susan.name}")
    expect(page).to have_content("Season Number: #{susan.season_number}")
    expect(page).to have_content("Description: #{susan.description}")
  end

  it 'I see a link to that bachelorettes contestants when I click that link I am taken to that bachelorettes contestants' do
    susan = Bachelorette.create!(name: 'Susan', season_number: 9, description: 'The best season')
    beth = Bachelorette.create!(name: 'Beth', season_number: 8, description: 'The worst season')
    sean = susan.contestants.create!(name: 'Sean', age: 31, hometown: 'Denver')
    sam = susan.contestants.create!(name: 'Sam', age: 30, hometown: 'Denver')
    seth = beth.contestants.create!(name: 'Seth', age: 29, hometown: 'Denver')
    visit "/bachelorettes/#{susan.id}"
    expect(page).to have_link("Bachelorette's Contestants")
    click_link("Bachelorette's Contestants")
    expect(current_path).to eq("/bachelorettes/#{susan.id}/contestants")
    expect(page).to have_content("#{sean.name}")
    expect(page).to have_content("#{sam.name}")
    expect(page).to_not have_content("#{seth.name}")
  end

  it 'I see an average age of all contestants on that season' do
    susan = Bachelorette.create!(name: 'Susan', season_number: 9, description: 'The best season')
    beth = Bachelorette.create!(name: 'Beth', season_number: 8, description: 'The worst season')
    sean = susan.contestants.create!(name: 'Sean', age: 32, hometown: 'Denver')
    sam = susan.contestants.create!(name: 'Sam', age: 30, hometown: 'Denver')
    seth = beth.contestants.create!(name: 'Seth', age: 29, hometown: 'Denver')
    visit "/bachelorettes/#{susan.id}"
    expect(page).to have_content("Average Age of Contestants: #{susan.average_age}")
  end
end
