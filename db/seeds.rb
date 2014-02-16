# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def print_errors(msg, o)
	if o.errors.any?
		puts msg
		o.errors.full_messages.each do |m|
			puts m
		end
	end
end

# Create admin
# User 1
u = User.create(name: "admin", password: "password", 
			password_confirmation: "password", utype: "instructor")

print_errors("Admin creation errors", u)

#Instructor 1
i = Instructor.create(email: "instructor@example.com", classname: "Test Class 101",
	semester: "Fall", first_name: "Bill", last_name: "Instructor", user_id: 1)

print_errors("Instructor creation errors", i)

2.times do |i|
	# User 2, 3
	u = User.create(name: "sponsor" + (i + 1).to_s, password: "password", 
				password_confirmation: "password", utype: "sponsor")

	print_errors("User creation errors (Sponsor)", u)

	# Create sponsors 1, 2
	s= Sponsor.create(first_name: (i + 1).to_s, last_name: "Sponsor",
			orgnization: "Org " + (1 + i).to_s, 
			email: "sponsor" + (1+ i).to_s + "@example.com", user_id: i + 2)

	print_errors("Sponsor creation errors", s)
end

# Create projects
2.times do |i|
	# Project 1, 2
	p = Project.create(name: "Project " + (i + 1).to_s, initial_capacity: 4,
		sponsor: Sponsor.find_by_id(i + 1), current_capacity: 4, semester: "Fall",
		active: 1, status: 1)
	print_errors("Project creation errors", p)
end

# Create Teams
2.times do |i|
	# Teams 1, 2
	t = Team.create(name: "Team " + (i + 1).to_s, project_id: i + 1, 
				google_drive: "http://www.google.com")

	print_errors("Team creation errors", t)
end

8.times do |i|
	# User 4, 5, 6, 7, 8, 9, 10, 11
	u = User.create(name: "student" + (i + 1).to_s, password: "password", 
				password_confirmation: "password", utype: "student")

	print_errors("User creation errors (student)", u)

	s = Student.create(email: "student" + (i + 1).to_s + "@example.com",
				first_name: (i + 1).to_s, last_name: "Student", major: "Computer Science",
				availability: 1, team_id: i.even? ? 1 : 2, user_id: i + 4,
				semester: "Fall", classname: "CSCE 486/488")

	print_errors("Studen creation errors", s)
end