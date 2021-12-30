require 'rails_helper'
describe 'bachelorette contestants index page' do
  it 'I see the the name, age and hometown of each contestant' do
    susan = Bachelorette.create!(name: 'Susan', season_number: 9, description: 'The best season')
    beth = Bachelorette.create!(name: 'Beth', season_number: 8, description: 'The worst season')
    sean = susan.contestants.create!(name: 'Sean', age: 31, hometown: 'Denver')
    sam = susan.contestants.create!(name: 'Sam', age: 30, hometown: 'Denver')
    seth = beth.contestants.create!(name: 'Seth', age: 29, hometown: 'Denver')
    visit "/bachelorettes/#{susan.id}/contestants"
    expect(page).to have_content("#{sean.name}")
    expect(page).to have_content("#{sean.age}")
    expect(page).to have_content("#{sean.hometown}")
    expect(page).to have_content("#{sam.name}")
    expect(page).to have_content("#{sam.age}")
    expect(page).to have_content("#{sam.hometown}")
    expect(page).to have_link("#{sean.name}")
    expect(page).to have_link("#{sam.name}")
  end

  it 'when I click the link I am taken to that contestants show page' do
    susan = Bachelorette.create!(name: 'Susan', season_number: 9, description: 'The best season')
    beth = Bachelorette.create!(name: 'Beth', season_number: 8, description: 'The worst season')
    sean = susan.contestants.create!(name: 'Sean', age: 31, hometown: 'Denver')
    sam = susan.contestants.create!(name: 'Sam', age: 30, hometown: 'Denver')
    seth = beth.contestants.create!(name: 'Seth', age: 29, hometown: 'Denver')
    visit "/bachelorettes/#{susan.id}/contestants"
    expect(page).to have_link("#{sean.name}")
    click_link("#{sean.name}")
    expect(current_path).to eq("/contestants/#{sean.id}")
    expect(page).to have_content("#{sean.name}")
  end

  it 'I see a unique list of all the hometowns of those contestants' do
    susan = Bachelorette.create!(name: 'Susan', season_number: 9, description: 'The best season')
    beth = Bachelorette.create!(name: 'Beth', season_number: 8, description: 'The worst season')
    sean = susan.contestants.create!(name: 'Sean', age: 31, hometown: 'Denver')
    sam = susan.contestants.create!(name: 'Sam', age: 30, hometown: 'DC')
    seth = susan.contestants.create!(name: 'Seth', age: 29, hometown: 'Denver')
    visit "/bachelorettes/#{susan.id}/contestants"
    within "#unique_hometowns-#{susan.id}" do
      expect(page).to have_content(sam.hometown)
      expect(page).to have_content(sean.hometown, count: 1)
    end
  end
end
