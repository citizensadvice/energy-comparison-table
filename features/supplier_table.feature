Feature: Energy Comparison Table

  Scenario: User can view detailed information for a ranked supplier
    Given I am on the Energy Supplier Table page
    When I select a supplier from the table
    Then I am taken to the supplier detail page

  @wip
  Scenario: User can return to the Energy Supplier Table page
    Given I am on a supplier detail page
    And I click to check the full table to compare more energy suppliers
    Then I am returned to the Energy Supplier Table page

  @wip
  Scenario: User can view more information about an unranked supplier
    Given I am on the Energy Supplier Table page
    When I select an unranked supplier from the dropdown
    And I click the "Search" button
    Then I am shown more information about that supplier on the current page

  @wip
  Scenario: Mobile user has a shortened supplier table
    Given I am on the Energy Supplier Table page
    And I am using a mobile device
    Then I am shown a shortened supplier table
    When I click on Show "more" suppliers
    Then I am shown the full supplier table
    When I click on Show "fewer" suppliers
    Then I am shown a shortened supplier table

  @wip
  Scenario: Mobile user has condensed navigation bar
    Given I am on the Energy Supplier Table page
    And I am using a mobile device
    Then I am shown a condensed navigation bar
    When I click on "More"
    Then the missing navigation titles are shown in a dropdown
    When I click on "Close"
    Then the navigation dropdown is closed