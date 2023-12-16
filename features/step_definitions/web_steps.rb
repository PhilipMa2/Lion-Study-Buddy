require 'rspec'

Given(/^the user visits the "([^"]*)" page$/) do |expected_path|
  visit path_to(expected_path)
end

Given /the following students exist/ do |students_table|
  @student = nil
  students_table.hashes.each do |student|
    @student = Student.create(student)
    Group.create(creator_id: @student.id, course: "Fundamental Analysis for Inves", capacity: 3, text: "Looking for a study partner")
  end
end

Given /the following courses exist/ do |courses_table|
  courses_table.hashes.each do |course|
    Course.create(course)
  end
end

Given(/^there are students with the following details:$/) do |table|
  table.hashes.each do |student|
    Student.create!(student)
  end
end

Given(/^there are groups with the following details:$/) do |table|
  table.hashes.each do |post|
    creator = Student.find_by(id: post['creator_id'])
    Group.create!(post.merge(creator: creator))
  end
end

Given(/^there are attendances with the following details:$/) do |table|
  table.hashes.each do |attendance|
    student = Student.find_by(id: attendance['student_id'])
    group = Group.find_by(id: attendance['group_id'])
    Application.create!(attendance.merge(student: student, group: group))
  end
end

When("the user logs in with correct credentials") do
  fill_in('email', with: "alice@columbia.edu")
  fill_in('passcode', with: "123456")
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
    expect(current_path).to eq('/groups/' + @specified_group_id)
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
  fill_in('email', with: "alice@columbia.edu")
  fill_in('passcode', with: "123456")
  click_button('Login')
end

When("fills in the group details") do
  select('ACCTB8010 Fundamental Analysis for Inves', from: 'group_course')
  fill_in('group_focus', with: "Study Focus")
  fill_in('group_text', with: "Study Text")
  fill_in('group_capacity', with: 3)
end

Then("the group should be created successfully") do
  expect(page).to have_content("ACCTB8010 Fundamental Analysis for Inves")
  expect(page).to have_content("Study Focus")
end

Given("there exists a created post in the user's profile") do
  visit path_to('profile')
  expect(page).to have_content("\Groups Created\nCourse: ")
end

Given("there exists a post to attend on the main page") do
  first('.group').click_link('View')
  expect(page).to have_content("Looking for a study partner")
end

Then("attend the post") do
  click_button('Request to Join')
  expect(page).to have_content("You are now attending this post")
end

Then("attend the post again") do
  click_button('Request to Join')
  expect(page).to have_content("You are already attending this post")
end

Given(/^the user selects the post to "([^"]*)"$/) do |button_to_click|
  # Identify and click the button/icon of the first post
  page_content = page.body
  match = /Course: (.*?), Schedule/.match(page_content)
  @specified_group_id = "1" # match[1] if match # should be "5" for our test case
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

Then(/^the user should see level (\d+) access information$/) do |access_level_str|
  access_level_int = access_level_str.to_i
  for accessible_item in should_see_access(access_level_int) do
    expect(page).to have_content(accessible_item)
  end
end

Then(/^the user should not see level (\d+) access information$/) do |access_level_str|
  access_level_int = access_level_str.to_i
  for unaccessible_item in should_not_see_access(access_level_int) do
    expect(page).not_to have_content(unaccessible_item)
  end
end

Then(/^the user should see "([^"]*)"$/) do |expected_content|
  expect(page).to have_content(expected_content)
end

Given('the following posts exist:') do |table|
  data = table.hashes.first
  fill_in 'post_creator_id', with: data['Creator ID']
  fill_in 'post_course', with: data['Course']
  fill_in 'post_capacity', with: data['Capacity']
  fill_in 'post_tag', with: data['Tag']
  fill_in 'post_text', with: data['Text']
end

Given('the following student_attend_posts exist:') do |table|
  data = table.hashes.first
  fill_in 'post_creator_id', with: data['Creator ID']
  fill_in 'post_course', with: data['Course']
  fill_in 'post_capacity', with: data['Capacity']
  fill_in 'post_tag', with: data['Tag']
  fill_in 'post_text', with: data['Text']
end

Then(/^the correct number of overlapping sessions should show up$/) do
  assert_equal expected_number, actual_number
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
  expected_time_slots = [15, 2, 16, 3, 17, 4, 18, 5, 19]
  actual_time_slots = @student.selected_time_slots
  expect(actual_time_slots).to eq(expected_time_slots)
end

Given /the user has already set their available time slots for the week/ do
  expected_time_slots = [15, 2, 16, 3, 17, 4, 18, 5, 19]
  expected_time_slots.each do |slot|
    check("time_slot_#{slot}")
  end
  click_button("Update")
  actual_time_slots = @student.selected_time_slots
  expect(actual_time_slots).to eq(expected_time_slots)
end

Then (/^the user's available time slots for the week are updated successfully$/) do
  expect(page).to have_content("Schedule saved successfully")
  expected_time_slots = [15, 2, 16, 3, 17, 45, 4, 18, 32, 46, 5, 19, 33, 47]
  actual_time_slots = @student.selected_time_slots
  expect(actual_time_slots).to eq(expected_time_slots)
end

Given /the user has already set their available time slots for the complete week/ do
  expected_time_slots = [15, 2, 16, 3, 17, 45, 4, 18, 32, 46, 5, 19, 33, 47]
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

Then(/^the user visits user ([^"]*)'s profile page$/) do |user_id|
  visit "http://127.0.0.1:3000/students/" +  user_id
end


# Given("the user is logged in") do
#   visit path_to('login')
#   fill_in('email', with: "frank@example.com")
#   fill_in('passcode', with: "frank789")
#   click_button('Login')
# end

Given('the user visits the study group page {int}') do |group_id|
  visit path_to("specified group #{group_id}")
end

Then("the pending request should show up in the requestee's profile") do
  visit path_to('profile')
  expect(page).to have_content('Course: Contemporary Latin American Art, Focus: art, Creator: Bob pending')
end

And("the pending request should show up in the requested's post") do
  visit path_to('logout')
  visit path_to('login')
  fill_in('email', with: "bob@columbia.edu")
  fill_in('passcode', with: "123456")
  click_button('Login')
  visit "http://127.0.0.1:3000/groups/2"
  expect(page).to have_content('Alice')
end

Given("the user visits a study group post page that they have created") do
  visit path_to("specified group 1")
end

Then("the request should fail") do
  expect(page).not_to have_content('Application submitted!')
end

Given("the user visits a study group post page that they are already accepted in") do
  visit path_to("specified group 3")
end

Then("the match request should be gone from their pending requests") do
  expect(page).not_to have_content('Accept')
end

Given("the requestee should have their pending request moved to matched requests") do
  visit path_to('logout')
  visit path_to('login')
  fill_in('email', with: "bob@columbia.edu")
  fill_in('passcode', with: "123456")
  click_button('Login')
  visit path_to("profile")
  expect(page).to have_content('Course: Fundamental Analysis for Inves, Focus: analysis, Creator: Alice ✅')
end

Given(/^the number of members in the post should increase by (\d+)$/) do |count|
  visit path_to("specified group 1")
  expect(page).to have_content("#{(count + 1).to_s} / 10")
end 

Given("the requestee should have their pending request removed") do
  visit path_to('logout')
  visit path_to('login')
  fill_in('email', with: "bob@columbia.edu")
  fill_in('passcode', with: "123456")
  click_button('Login')
  visit path_to("profile")
  expect(page).not_to have_content('Course: Fundamental Analysis for Inves, Focus: analysis, Creator: Alice')
end

Given('I visit the home page') do
  visit root_path
end

And('I fill in {string} with {string}') do |field, value|
  fill_in field, with: value
end

And('I press {string}') do |button|
  click_button button
end

Then('I should see all the groups') do
  Group.all do |group|
    expect(page).to have_content(group.course)
  end
end

Then('I should see groups with a capacity of {int} or less') do |capacity|
  Group.where('capacity <= ?', capacity).each do |group|
    expect(page).to have_content(group.course)
  end
end

Then('I should see groups related to {string}') do |search_term|
  Group.where('LOWER(course) LIKE ?', "%#{search_term.downcase}%").each do |group|
    expect(page).to have_content(group.course)
  end
end
# ////////////////////////
When('I click the "Create Account" button') do
  # page.execute_script("document.getElementById('submitBtn').disabled = false;")
  click_button('Create Account')
end

Then('I should be redirected to the login page') do
  puts page.body
  expect(current_path).to eq path_to('login')
end

Then('I should be redirected to the profile page') do
  expect(current_path).to eq profile_path(@student)
end

Then('I should see {string}') do |text|
  expect(page).to have_content(text)
end

When('I visit the profile page') do
  visit profile_path(@student)
end

When('I fill in the new account details with valid information') do
  fill_in 'email', with: 'newuser@columbia.edu'
  fill_in 'password', with: '123456'
  fill_in 'password_confirmation', with: '123456'
  fill_in 'name', with: 'New User'
end

When('I fill in the new account details with an existing email') do
  fill_in 'email', with: 'alice@columbia.edu'
  fill_in 'password', with: '123456'
  fill_in 'password_confirmation', with: '123456'
  fill_in 'name', with: 'Alice'
end

When('I fill in the new account details with mismatching passwords') do
  fill_in 'email', with: 'newuser@example.com'
  fill_in 'password', with: '123456'
  fill_in 'password_confirmation', with: 'differentpassword'
  fill_in 'name', with: 'New User'
end