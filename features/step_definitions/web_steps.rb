require 'rspec'

Given(/^the user visits the "([^"]*)" page$/) do |expected_path|
  visit path_to(expected_path)
end

When("the user logs in with correct credentials") do
  find('#email').set("frank@example.com")
  fill_in('passcode', with: "frank789")
  click_button("Login")
end

When("the user logs in with wrong credentials") do
  find('#email').set("frank@example.com")
  fill_in('passcode', with: "bad_passcode")
  click_button("Login")
end

When(/^the user clicks the "([^"]*)" button$/) do |button_name|
  click_button(button_name)
end

Then("the user should be logged in successfully") do
  visit path_to("profile")
  expect(page).to have_content("#{@firstname}'s Profile")
  expect(current_path).to eq('/profile')
end

Given("an unauthenticated user") do
  Capybara.reset_session!
end

Then(/^the user should be directed to the "([^"]*)" page$/) do |expected_path|
  expect(current_path).to eq('/' + (expected_path != "home" ? expected_path : ""))
end

Then("the user should be logged out") do
  expect(page).to have_content('Login') 
  expect(page).not_to have_content("#{@firstname}'s Profile") # to check absence of logged-in user content
end

Given("the user is logged in") do
  visit path_to('login')
  fill_in('email', with: "frank@example.com")
  fill_in('passcode', with: @passcode)
  click_button('Login')
end

When("fills in the post details") do
  fill_in('Course', with: @testcourse)
  fill_in('Tag', with: @testtag)
end

Then("the post should be created successfully") do
  expect(page).to have_content(@testcourse)
  expect(page).to have_content(@testtag)
end

Given("there exists a post in the user's profile") do
  visit path_to('new post')
  fill_in('course', with: @testcourse)
  fill_in('tag', with: @testtag)
  click_button('Create')
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
  fill_in('Course', with: @testEditedCourse)
  fill_in('Tag', with: @testEditedTag)
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

Then(/^the user should see "([^"]*)"$/) do |expected_content|
  expect(page).to have_content(expected_content)
end

Given('the following posts exist:') do |table|
  table.hashes.each do |post|
    creator_name = post['creator_name']
    creator_id = post['creator_id']
    course = post['course']
    schedule = post['schedule']
    tag = post['tag']
    text = post['text']

    # Here you would write the code to create posts in your system or database
    # This code would depend on the structure of your application and how posts are created

    # As an example, let's say you're adding posts via a form:
    visit('/new post') # Navigating to the new post creation page
    fill_in('Creator Name', with: creator_name)
    fill_in('Creator ID', with: creator_id)
    fill_in('Course', with: course)
    fill_in('Schedule', with: schedule)
    fill_in('Tag', with: tag)
    fill_in('Text', with: text)
    click_button('Create') # Submit the form to create the post
  end
end
