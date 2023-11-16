student1 = Student.create(email: "alice@columbia.com", passcode: "123456", name: "Alice", course: "COMPUTATIONAL GENOMICS, INTRO-COMPUT SCI/PROG IN JAVA, EMERGING SCHOLARS PROG SEMINAR, ", schedule: "Mon-Wed-Fri 9AM-11AM", tag: "Freshman", text: "Interested in AI and ML")
student2 = Student.create(email: "bob@columbia.com", passcode: "123456", name: "Bob", course: "DEVELOPMENT TECHNOLOGY, Intermediate Computing in Python, DATA STRUCTURES IN JAVA", schedule: "Tue-Thu 2PM-4PM", tag: "Sophomore", text: "Love database management")
student3 = Student.create(email: "carol@example.com", passcode: "carol123", name: "Carol", course: "ADVANCED PROGRAMMING, DISCRETE MATHEMATICS", schedule: "Mon 1PM-3PM", tag: "Junior", text: "Robotics enthusiast")
student4 = Student.create(email: "dave@example.com", passcode: "davepass", name: "Dave", course: "PROGRAMMING LANG & TRANSLATORS, OPERATING SYSTEMS I, COMPUTER GRAPHICS", schedule: "Fri 3PM-5PM", tag: "Senior", text: "Working on a drone project")
student5 = Student.create(email: "frank@example.com", passcode: "frank789", name: "Frank", course: "USER INTERFACE DESIGN", schedule: "Mon-Wed-Fri 2PM-4PM", tag: "Junior", text: "Researching on marine life")

post1 = Post.create(creator_id: student1.id, course: "COMPUTATIONAL GENOMICS", capacity: 12, tag: student1.tag, text: student1.text, post_status: "open")
post2 = Post.create(creator_id: student2.id, course: "DEVELOPMENT TECHNOLOGY", capacity: 12, tag: student2.tag, text: student2.text, post_status: "open")
post3 = Post.create(creator_id: student3.id, course: "ADVANCED PROGRAMMING", capacity: 12, tag: student3.tag, text: student3.text, post_status: "open")
post4 = Post.create(creator_id: student4.id, course: "PROGRAMMING LANG & TRANSLATORS", capacity: 12, tag: student4.tag, text: student4.text, post_status: "open")
post5 = Post.create(creator_id: student5.id, course: "USER INTERFACE DESIGN", capacity: 12, tag: student5.tag, text: student5.text, post_status: "open")

StudentAttendPost.create(student_id: student1.id, post_id: post2.id)
StudentAttendPost.create(student_id: student2.id, post_id: post1.id)