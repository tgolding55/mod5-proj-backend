CommentLike.delete_all
ProjectComment.delete_all
ProjectLike.delete_all
UserLike.delete_all
Collaborator.delete_all
Project.delete_all
User.delete_all


project1 = Project.create({title: "the test project", description: "The test projects descriptions", technologies_used: "Php, just php", collaborator_size_limit: 4, status: "In Progress", github_link: 'https://github.com/tgolding55/tankgame', timeframe: 5})
project2 = Project.create({title: "the second test project", description: "The second test projects descriptions", technologies_used: "Not Php, anything but php", collaborator_size_limit: 1, status: "Completed", github_link: 'https://github.com/tgolding55/hogwarts-react', timeframe: 2})

user1 = User.create({username: "john", password: "123", bio:"I am john and this is a bio"})
user2 = User.create({username: "tim", password: "123", bio:"I am not john, however, this is still a bio"})

collaborator1 = Collaborator.create(user_id: user1.id,project_id: project1.id, role:'lead')
collaborator2 = Collaborator.create(user_id: user2.id,project_id: project1.id, role:'user')

comment1 = ProjectComment.create(user_id: user1.id,project_id: project1.id, content:'THIS IS A COMMENT')
comment2 = ProjectComment.create(user_id: user2.id,project_id: project1.id, content:'THIS IS ALSO A COMMENT')

projectlike1 = ProjectLike.create(user_id: user1.id, project_id: project1.id)
projectlike2 = ProjectLike.create(user_id: user2.id, project_id: project1.id)

commentlike1 = CommentLike.create(user_id: user1.id, project_comment_id: comment1.id)
commentlike2 = CommentLike.create(user_id: user2.id, project_comment_id: comment2.id)

userlike1 = user1.likees << user2

