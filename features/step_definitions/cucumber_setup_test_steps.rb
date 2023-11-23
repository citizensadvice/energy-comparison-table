# frozen_string_literal: true

Given("I am on the Energy Comparison Table page") do
  visit "/"
end

Then("I should see {string}") do |text|
  expect(page).to have_text(text)
end
