# ./vendor/bin/behat -c tests/Integration/Behaviour/behat.yml -s product --tags category-tree
@reset-database-before-feature
@clear-cache-before-feature
@category-tree
Feature: Show category tree in product page (BO)
  As an employee
  I need to be able to see category tree in product page with marked product-category associations

  Background:
    Given language with iso code "en" is the default one
    And category "home" in default language named "Home" exists
    And category "clothes" in default language named "Clothes" exists
    And category "clothes" parent is category "home"
    And category "men" in default language named "Men" exists
    And category "men" parent is category "clothes"
    And category "women" in default language named "Women" exists
    And category "women" parent is category "clothes"
    And category "accessories" in default language named "Accessories" exists
    And category "accessories" parent is category "home"
    And category "stationery" in default language named "Stationery" exists
    And category "stationery" parent is category "accessories"
    And category "home_accessories" in default language named "Home Accessories" exists
    And category "home_accessories" parent is category "accessories"
    And category "art" in default language named "Art" exists
    And category "art" parent is category "home"

  Scenario: I can see categories tree with product associations
    Given I add product "product1" with following information:
      | name[en-US] | unisex sneakers |
      | type        | standard        |
    And product "product1" type should be standard
    And product "product1" should be assigned to default category
    Then I should see following root categories for product "product1" in "en" language:
      | id reference | category name | direct child categories   | is associated with product |
      | home         | Home          | [clothes,accessories,art] | true                       |
    And I should see following categories in "home" category for product "product1" in "en" language:
      | id reference | category name | direct child categories       | is associated with product |
      | clothes      | Clothes       | [men,women]                   | false                      |
      | accessories  | Accessories   | [stationery,home_accessories] | false                      |
      | art          | Art           |                               | false                      |
    And I should see following categories in "clothes" category for product "product1" in "en" language:
      | id reference | category name | direct child categories | is associated with product |
      | men          | Men           |                         | false                      |
      | women        | Women         |                         | false                      |
    And I should see following categories in "accessories" category for product "product1" in "en" language:
      | id reference     | category name    | direct child categories | is associated with product |
      | stationery       | Stationery       |                         | false                      |
      | home_accessories | Home Accessories |                         | false                      |
