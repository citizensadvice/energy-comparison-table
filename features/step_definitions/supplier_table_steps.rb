# frozen_string_literal: true

Given("I am on the Energy Supplier Table page") do
  visit CSR_APP_PATH
end

When("I select a supplier from the table") do
  big_energy_inc = find("[data-testid='supplier-big-energy-inc']")
  within(big_energy_inc) do
    click_on "More details"
  end
end

Then("I am taken to the supplier detail page") do
  expect(page).to have_current_path("#{CSR_APP_PATH}big-energy-inc/details")
end

Given("I am on a supplier detail page") do
  visit "#{CSR_APP_PATH}big-energy-inc/details"
end

And("I click to check the full table to compare more energy suppliers") do
  click_on "Check the full table to compare more energy suppliers' customer service"
end

Then("I am returned to the Energy Supplier Table page") do
  expect(page).to have_css ".cads-page-title", text: "Compare energy suppliers' customer service"
end

When("I select an unranked supplier from the dropdown") do
  within(".unranked-suppliers__form") do
    select("Beach Kenergy", from: "id-input")
  end
end

And("I click the {string} button") do |text|
  within(".unranked-suppliers__form") do
    click_button text
  end
end

Then("I am shown more information about that supplier on the current page") do
  expect(page).to have_css("[data-testid='unranked-supplier-details-beach-kenergy']")
end

And("I am using a mobile device") do
  Capybara.current_window.resize_to(360, 640)
end

Then("I am shown a shortened supplier table") do
  expect(page).to have_css ".supplier-table__row", count: 5
end

When("I click on Show {string} suppliers") do |text|
  within(".supplier-table--show-#{text}") do
    click_button "Show #{text} suppliers"
  end
end

Then("I am shown the full supplier table") do
  expect(page).to have_css ".supplier-table__row--hidden", count: 0
end

Then("I am shown a condensed navigation bar") do
  expect(page).to have_css ".cads-greedy-nav-has-dropdown"
end

When("I click on {string}")do |text|
  within(".cads-navigation") do
    click_button text
  end
end

Then("the missing navigation titles are shown in a dropdown") do
  expect(page).to have_css("[class='cads-greedy-nav__dropdown show']")
end

Then("the navigation dropdown is closed") do
  expect(page).not_to have_css("[class='cads-greedy-nav__dropdown show']")
end
