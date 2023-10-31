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
  expect(page).to have_content("Frank's Profile")
  expect(current_path).to eq('/profile')
end

Given("an unauthenticated user") do
  Capybara.reset_session!
end

Then(/^the user should be directed to the "([^"]*)" page$/) do |expected_path|
  if (expected_path == "specified post")
    expect(current_path).to eq('/posts/' + @specified_post_id)
  else
    expect(current_path).to eq('/' + (expected_path != "home" ? expected_path : ""))
  end
end

Then("the user should be logged out") do
  expect(page).to have_content('Login') 
  expect(page).not_to have_content("#{@firstname}'s Profile") # to check absence of logged-in user content
end

Given("the user is logged in") do
  visit path_to('login')
  fill_in('email', with: "frank@example.com")
  fill_in('passcode', with: "frank789")
  click_button('Login')
end

When("fills in the post details") do
  fill_in('Course', with: "COMS4107")
  fill_in('Tag', with: "midterm study")
end

Then("the post should be created successfully") do
  expect(page).to have_content("COMS4107")
  expect(page).to have_content("midterm study")
end

Given("there exists a created post in the user's profile") do
  visit path_to('profile')
  expect(page).to have_content("\nPosts Created\nCourse: ")
end

When("selects the post to delete") do
  # Identify and click the delete button/icon of the first post
  # TODO: Set @specified_post_id to top post to be deleted
  @specified_post_id = "5"
  click_button('Cancel', :match => :first)
end

When("selects the post to confirm") do
  click_button('Confirm', :match => :first)
end

When("updates the post details") do
  fill_in('Course', with: "COMS1001")
  fill_in('Tag', with: "Project Partner")
end

When("saves the changes") do
  click_button('Save Changes') # Assuming this is your application's save changes button
end

Then("the post should be deleted from the user's profile") do
  expect(page).not_to have_content("COMS4107")
end

Then("the post should be confirmed successfully") do
  # TODO: define "confirming" a post
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
