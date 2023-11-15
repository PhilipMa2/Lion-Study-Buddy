require 'rspec'

Given(/^the user visits the "([^"]*)" page$/) do |expected_path|
  visit path_to(expected_path)
end

Given /the following students exist/ do |students_table|
  @student = nil
  students_table.hashes.each do |student|
    @student = Student.create(student)
    Post.create(creator_name: @student.name, creator_id: @student.id, course: @student.course, start_slot: 28, end_slot: 30, tag: @student.tag, text: "Looking for a study partner 5")
  end
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
  visit('profile')
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

Given("there exists a post to attend on the main page") do
  first('.post').click_link('View')
  expect(page).to have_content("Looking for a study partner")
end

Then("attend the post") do
  click_button('Attend')
  expect(page).to have_content("You are now attending this post")
end

Then("attend the post again") do
  click_button('Attend')
  expect(page).to have_content("You are already attending this post")
end

Given(/^the user selects the post to "([^"]*)"$/) do |button_to_click|
  # Identify and click the button/icon of the first post
  page_content = page.body
  match = /Course: (.*?), Schedule/.match(page_content)
  @specified_post_id = "1" # match[1] if match # should be "5" for our test case
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

Then(/^the correct number of overlapping sessions should show up$/) do
  assert_equal expected_number, actual_number
end

And(/^the pending request should show up in the requested's inbox$/) do
  
  assert page.has_content?('Pending Request'), "Pending request not found in inbox"
end

And(/^the pending request should show up in the requestee's profile$/) do
  # Implement code to check if the pending request is present in the requestee's profile
  # For example, assert page.has_content?('Pending Request'), "Pending request not found in profile"
end

When /the user indicates their available time slots for each day/ do |schedule|
  schedule.hashes.each do |row|
    day = row['Day'].to_i - 1
    available_time = row['Available Time Slots'].split(',').map(&:strip)
    available_time.each do |slot|
      slot = slot.to_i
      slot_id = (slot - 8) + day * 13 + 1
      checkbox_id = "time_slot_#{slot_id}"
      check(checkbox_id)
    end
  end
end

Then (/^the user's available time slots for the week are saved successfully$/) do
  expect(page).to have_content("Schedule saved successfully")
  expected_time_slots = [2, 15, 3, 16, 4, 17, 5, 18, 19]
  actual_time_slots = @student.selected_time_slots
  expect(actual_time_slots).to eq(expected_time_slots)
end

Given /the user has already set their available time slots for the week/ do
  expected_time_slots = [2, 15, 3, 16, 4, 17, 5, 18, 19]
  expected_time_slots.each do |slot|
    check("time_slot_#{slot}")
  end
  click_button("Update")
  actual_time_slots = @student.selected_time_slots
  expect(actual_time_slots).to eq(expected_time_slots)
end

Then (/^the user's available time slots for the week are updated successfully$/) do
  expect(page).to have_content("Schedule saved successfully")
  expected_time_slots = [2, 15, 3, 16, 4, 17, 5, 18, 19, 32, 45, 33, 46, 47]
  actual_time_slots = @student.selected_time_slots
  expect(actual_time_slots).to eq(expected_time_slots)
end

Given /the user has already set their available time slots for the complete week/ do
  expected_time_slots = [2, 15, 3, 16, 4, 17, 5, 18, 19, 32, 45, 33, 46, 47]
  expected_time_slots.each do |slot|
    check("time_slot_#{slot}")
  end
  click_button("Update")
  actual_time_slots = @student.selected_time_slots
  expect(actual_time_slots).to eq(expected_time_slots)
end

And /the user clears their available time slots for each day/ do
  time_slots = [2, 15, 3, 16, 4, 17, 5, 18, 19, 32, 45, 33, 46, 47]
  time_slots.each do |slot|
    uncheck("time_slot_#{slot}")
  end
end

Then (/^the user's available time slots for the week are cleared successfully$/) do
  expected_time_slots = []
  actual_time_slots = @student.selected_time_slots
  expect(actual_time_slots).to eq(expected_time_slots)
end
