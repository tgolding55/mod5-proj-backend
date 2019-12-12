# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Collaborator.delete_all
Project.delete_all
User.delete_all
ProjectComment.delete_all

project1 = Project.create({title: "the test project", description: "The test projects descriptions", technologies_used: "Php, just php", collaborator_size_limit: 4, status: "in progress"})
project2 = Project.create({title: "the second test project", description: "The second test projects descriptions", technologies_used: "Not Php, anything but php", collaborator_size_limit: 1, status: "completed"})

user1 = User.create({username: "john", password: "123", bio:"I am john and this is a bio"})
user2 = User.create({username: "tim", password: "123", bio:"I am not john, however, this is still a bio"})

collaborator1 = Collaborator.create(user_id: user1.id,project_id: project1.id, role:'lead')
collaborator2 = Collaborator.create(user_id: user2.id,project_id: project1.id, role:'user')

comment1 = ProjectComment.create(user_id: user1.id,project_id: project1.id, content:'THIS IS A COMMENT')
comment2 = ProjectComment.create(user_id: user2.id,project_id: project1.id, content:'THIS IS ALSO A COMMENT')
