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
    course: "COMPUTATIONAL GENOMICS, INTRO-COMPUT SCI/PROG IN JAVA, EMERGING SCHOLARS PROG SEMINAR, ", 
    schedule: "Mon-Wed-Fri 9AM-11AM", 
    focus: "Java", 
    text: "Interested in AI and ML")

student2 = Student.create(email: "bob@columbia.edu", 
    passcode: "123456", 
    name: "Bob", 
    course: "DEVELOPMENT TECHNOLOGY, Intermediate Computing in Python, DATA STRUCTURES IN JAVA", 
    schedule: "Tue-Thu 2PM-4PM", 
    focus: "Data Structures", 
    text: "Love database management")

student3 = Student.create(email: "carol@columbia.edu", 
    passcode: "123456", 
    name: "Carol", 
    course: "ADVANCED PROGRAMMING, DISCRETE MATHEMATICS", 
    schedule: "Mon 1PM-3PM", 
    focus: "Mathematics", 
    text: "Robotics enthusiast")

student4 = Student.create(email: "dave@columbia.edu", 
    passcode: "123456", 
    name: "Dave", 
    course: "PROGRAMMING LANG & TRANSLATORS, OPERATING SYSTEMS I, COMPUTER GRAPHICS", 
    schedule: "Fri 3PM-5PM", 
    focus: "Graphics", 
    text: "Working on a drone project")

student5 = Student.create(email: "frank@columbia.edu", 
    passcode: "123456", 
    name: "Frank", 
    course: "USER INTERFACE DESIGN", 
    schedule: "Mon-Wed-Fri 2PM-4PM", 
    focus: "UI/UX", 
    text: "Researching on marine life")





    
group1 = Group.create(creator_id: student1.id, 
    course: "COMPUTATIONAL GENOMICS", 
    capacity: 12, 
    focus: student1.focus, 
    text: student1.text, 
    group_status: "open")

group2 = Group.create(creator_id: student2.id, 
    course: "DEVELOPMENT TECHNOLOGY", 
    capacity: 12, 
    focus: student2.focus, 
    text: student2.text, 
    group_status: "open")

group3 = Group.create(creator_id: student3.id, 
    course: "ADVANCED PROGRAMMING", 
    capacity: 12, 
    focus: student3.focus, 
    text: student3.text, 
    group_status: "open")

group4 = Group.create(creator_id: student4.id, 
    course: "PROGRAMMING LANG & TRANSLATORS", 
    capacity: 12, 
    focus: student4.focus, 
    text: student4.text, 
    group_status: "open")

group5 = Group.create(creator_id: student5.id, 
    course: "USER INTERFACE DESIGN", 
    capacity: 12, 
    focus: student5.focus, 
    text: student5.text, 
    group_status: "open")

Application.create(student_id: student1.id, group_id: group2.id)
Application.create(student_id: student2.id, group_id: group1.id)