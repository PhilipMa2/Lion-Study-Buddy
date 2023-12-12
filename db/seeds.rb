require 'csv'

# Clear existing records to avoid duplicates during development
Course.destroy_all

# Path to your CSV file
csv_file = Rails.root.join('db/courses.csv')

# Read CSV file and seed the database
CSV.foreach(csv_file, headers: true) do |row|
  Course.create(course_id: row['course_id'], course_name: row['course_name'])
end

student1 = Student.create(email: "alice@columbia.edu", 
    passcode: "123456", 
    name: "Alice", 
    text: "Interested in AI and ML")

student2 = Student.create(email: "bob@columbia.edu", 
    passcode: "123456", 
    name: "Bob", 
    text: "Love database management")

student3 = Student.create(email: "carol@columbia.edu", 
    passcode: "123456", 
    name: "Carol", 
    text: "Robotics enthusiast")

student4 = Student.create(email: "dave@columbia.edu", 
    passcode: "123456", 
    name: "Dave", 
    text: "Working on a drone project")

student5 = Student.create(email: "frank@columbia.edu", 
    passcode: "123456", 
    name: "Frank", 
    text: "Researching on marine life")





    
group1 = Group.create(creator_id: student1.id, 
    course: "CBMFW4761 COMPUTATIONAL GENOMICS", 
    capacity: 2, 
    focus: 'Biology', 
    text: student1.text, 
    group_status: "open")

group2 = Group.create(creator_id: student2.id, 
    course: "COMSW3102 DEVELOPMENT TECHNOLOGY", 
    capacity: 5, 
    focus: 'Technology', 
    text: student2.text, 
    group_status: "open")

group3 = Group.create(creator_id: student3.id, 
    course: "COMSW3157 ADVANCED PROGRAMMING", 
    capacity: 10, 
    focus: 'Programming', 
    text: student3.text, 
    group_status: "open")

group4 = Group.create(creator_id: student4.id, 
    course: "COMSW4115 PROGRAMMING LANG & TRANSLATORS", 
    capacity: 15, 
    focus: 'Compiler', 
    text: student4.text, 
    group_status: "open")

group5 = Group.create(creator_id: student5.id, 
    course: "COMSW4170 USER INTERFACE DESIGN", 
    capacity: 20, 
    focus: 'ui', 
    text: student5.text, 
    group_status: "open")

Application.create(student_id: student1.id, group_id: group2.id)
Application.create(student_id: student2.id, group_id: group1.id)
Application.create(student_id: student3.id, group_id: group1.id)