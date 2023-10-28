@username = "cs1234"
@password = "valid_password"
@firstname = "Christina"
@lastname = "Smith"
@testcourse = "COMS4152"
@testtag = "project"
@testEditedCourse = "CALC1201"
@testEditedTag = "midterm"

Given(/^the user visits the "([^"]*)" page$/) do |expected_path|
  visit('/' + expected_path)
end

When("the user enters valid username and password") do
  fill_in('username', with: @username)
  fill_in('password', with: @password)
end

When("the user enters wrong credentials") do
  fill_in('username', with: @username)
  fill_in('password', with: "bad_password")
end

When(/^the user clicks the "([^"]*)" button$/) do |button_name|
  click_button(button_name)
end

Then("the user should be logged in successfully") do
  expect(page).to have_content("Welcome, #{@firstname}!")
  assert_equal(current_path, '/profile')
end

Given("an unauthenticated user") do
  clear_session
end

Then(/^the user should be directed to the "([^"]*)" page$/) do |expected_path|
  assert_equal(current_path, '/' + expected_path)
end

Then(/^the user should be redirected back to "([^"]*)"$/) do |expected_path|
  expect(current_path).to eq(expected_path)
end

Then("the user should be logged out") do
  expect(page).to have_content('Login') 
  expect(page).not_to have_content("Welcome, #{@firstname}!") # to check absence of logged-in user content
end

Given("the user is logged in") do
  visit('/login')
  fill_in('username', with: @username)
  fill_in('password', with: @password)
  click_button('login')
end

When("fills in the post details") do
  fill_in('course', with: @testcourse)
  fill_in('tag', with: @testtag)
end

Then("the post should be created successfully") do
  expect(page).to have_content(@testcourse)
  expect(page).to have_content(@testtag)
end

Given("there exists a post in the user's profile") do
  visit('/create_post')
  fill_in('course', with: @testcourse)
  fill_in('tag', with: @testtag) 
  click_button('submit')
end

When("selects the post to delete") do
  # Identify and click the delete button/icon of the post
  click_button('delete')
end

When("confirms the deletion") do
  # Confirm the deletion, could be a pop-up confirmation or a secondary action
  click_button('Confirm') # Assuming a confirmation button after selecting to delete
end

When("selects the post to edit") do
  # Identify and click the delete button/icon of the post
  click_button('edit')
end

When("updates the post details") do
  fill_in('course', with: @testEditedCourse)
  fill_in('tag', with: @testEditedTag)
end

When("saves the changes") do
  click_button('Save Changes') # Assuming this is your application's save changes button
end

Then("the post should be deleted from the user's profile") do
  expect(page).not_to have_content(@testcourse)
end

Then("the post should be edited successfully") do
  expect(page).to have_content(@testEditedCourse)
  expect(page).to have_content(@testEditedTag)
end
