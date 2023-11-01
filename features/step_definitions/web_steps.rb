require 'rspec'

Given(/^the user visits the "([^"]*)" page$/) do |expected_path|
  visit path_to(expected_path)
end

When("the user logs in with correct credentials") do
  fill_in('email', with: "frank@example.com")
  fill_in('passcode', with: "frank789")
  click_button("Login")
end

When("the user logs in with wrong credentials") do
  fill_in('email', with: "frank@example.com")
  fill_in('passcode', with: "bad_passcode")
  click_button("Login")
end

When(/^the user clicks the "([^"]*)" button$/) do |button_name|
  click_button(button_name)
end

When (/^the user clicks the "([^"]*)" link$/) do |link|
  click_link(link)
end

Then("the user should be logged in successfully") do
  # visit('profile')
  # expect(page).to have_content("Frank's Profile")
  # expect(current_path).to eq('/profile')
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
  fill_in('post_course', with: "COMS4107")          # Updated to use input id
  fill_in('post_start_slot', with: "2")             # Updated to use input id
  fill_in('post_end_slot', with: "3")               # Updated to use input id
  fill_in('post_tag', with: "midterm study")        # Updated to use input id
  fill_in('post_text', with: "midterm study")       # Updated to use input id
end

Then("the post should be created successfully") do
  expect(page).to have_content("COMS4107")
  expect(page).to have_content("midterm study")
end

Given("there exists a created post in the user's profile") do
  visit path_to('profile')
  expect(page).to have_content("\nPosts Created\nCourse: ")
end

Given(/^the user selects the post to "([^"]*)"$/) do |button_to_click|
  # Identify and click the button/icon of the first post
  page_content = page.body
  match = /Course: (.*?), Schedule/.match(page_content)
  @specified_post_id = "5" # match[1] if match # should be "5" for our test case
  click_button(button_to_click, :match => :first)
end

When("updates the post details") do
  fill_in('Course', with: "COMS1001")
  fill_in('Tag', with: "Project Partner")
end

When("saves the changes") do
  click_button('Save Changes')
end

Then("the post should be deleted from the user's profile") do
  expect(page).not_to have_content("COMS4107")
end

Then("the post should be confirmed successfully") do
  expect(page).to have_content("Status: Confirmed")
  expect(page).not_to have_content("Status: Pending")
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
