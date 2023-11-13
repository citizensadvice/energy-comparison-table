# frozen_string_literal: true

Given("I am on the Energy Supplier Table page") do
  visit CSR_APP_PATH
end

Then("the current path should be {string}") do |path|
  puts page.current_url
  expect(page).to have_current_path(path)
end

And("I should see a table of ranked energy suppliers") do
  expect(page).to have_css "[data-testid='supplier-table']"
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
