# # Create some fake students
# students = 10.times.map do
# 	Student.create!(
# 	  email: Faker::Internet.unique.email,
# 	  passcode: Faker::Internet.password,
# 	  name: Faker::Name.name,
# 	  course: Faker::Educator.course_name,
# 	  schedule: "#{Faker::Time.forward(days: 23, period: :morning).strftime('%H:%M')} - #{Faker::Time.forward(days: 23, period: :afternoon).strftime('%H:%M')}",
# 	  tag: Faker::Lorem.word,
# 	  text: Faker::Lorem.sentence(word_count: 3)
# 	)
#   end
  
#   # Create some fake posts using the students we just created
#   posts = 10.times.map do
# 	student = students.sample
# 	Post.create!(
# 	  creator_name: student.name,
# 	  creator_id: student.id,
# 	  course: Faker::Educator.course_name,
# 	  schedule: "#{Faker::Time.forward(days: 23, period: :morning).strftime('%H:%M')} - #{Faker::Time.forward(days: 23, period: :afternoon).strftime('%H:%M')}",
# 	  tag: Faker::Lorem.word,
# 	  text: Faker::Lorem.sentence(word_count: 5)
# 	)
#   end
  
#   # Create some StudentAttendPost entries
#   10.times do
# 	student = students.sample
# 	post = posts.sample
  
# 	StudentAttendPost.create!(
# 	  student_id: student.id,
# 	  post_id: post.id
# 	)
#   end

# seeds.rb

# Create some students
student1 = Student.create(email: "alice@columbia.com", passcode: "123456", name: "Alice", course: "Computer Science", schedule: "Mon-Wed-Fri 9AM-11AM", tag: "Freshman", text: "Interested in AI and ML")
student2 = Student.create(email: "bob@columbia.com", passcode: "123456", name: "Bob", course: "Information Systems", schedule: "Tue-Thu 2PM-4PM", tag: "Sophomore", text: "Love database management")
student3 = Student.create(email: "carol@example.com", passcode: "carol123", name: "Carol", course: "Electrical Engineering", schedule: "Mon 1PM-3PM", tag: "Junior", text: "Robotics enthusiast")
student4 = Student.create(email: "dave@example.com", passcode: "davepass", name: "Dave", course: "Mechanical Engineering", schedule: "Fri 3PM-5PM", tag: "Senior", text: "Working on a drone project")
student5 = Student.create(email: "frank@example.com", passcode: "frank789", name: "Frank", course: "Biology", schedule: "Mon-Wed-Fri 2PM-4PM", tag: "Junior", text: "Researching on marine life")

# Create some posts
post1 = Post.create(creator_name: student1.name, creator_id: student1.id, course: student1.course, start_slot: 10, end_slot: 12, tag: student1.tag, text: "Looking for a study partner 1")
post2 = Post.create(creator_name: student2.name, creator_id: student2.id, course: student2.course, start_slot: 30, end_slot: 31, tag: student2.tag, text: "Looking for a study partner 2")
post3 = Post.create(creator_name: student3.name, creator_id: student3.id, course: student3.course, start_slot: 14, end_slot: 15, tag: student3.tag, text: "Looking for a study partner 3")
post4 = Post.create(creator_name: student4.name, creator_id: student4.id, course: student4.course, start_slot: 45, end_slot: 46, tag: student4.tag, text: "Looking for a study partner 4")
post5 = Post.create(creator_name: student5.name, creator_id: student5.id, course: student5.course, start_slot: 28, end_slot: 30, tag: student5.tag, text: "Looking for a study partner 5")

# Show that student1 is attending the post created by student2 and vice versa
StudentAttendPost.create(student_id: student1.id, post_id: post2.id)
StudentAttendPost.create(student_id: student2.id, post_id: post1.id)
