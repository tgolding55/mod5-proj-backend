CommentLike.delete_all
ProjectComment.delete_all
ProjectLike.delete_all
ProjectMessage.delete_all
UserLike.delete_all
Collaborator.delete_all
Project.delete_all
User.delete_all


project1 = Project.create({title: "Tank Game", description: "A tank game made with websockets", technologies_used: "Node.js and websockets", collaborator_size_limit: 1, status: "In Progress", github_link: 'https://github.com/tgolding55/tankgame', timeframe: 5})
project2 = Project.create({title: "Hogwarts practice challenge", description: "React lab for hogwarts", technologies_used: "React", collaborator_size_limit: 2, status: "Completed", github_link: 'https://github.com/tgolding55/hogwarts-react', timeframe: 2})
project3 = Project.create({title: "Collabapage", description: "Project Collaboration site", technologies_used: "React and Rails!", collaborator_size_limit: 10, status: "In Progress", github_link: 'https://github.com/tgolding55/mod5-proj-frontend', timeframe: 2})

user1 = User.create({username: "david", password: "123", bio:"I am david and this is a bio"})
user2 = User.create({username: "tim", password: "123", bio:"I am not david, however, this is still a bio"})

collaborator1 = Collaborator.create(user_id: user2.id,project_id: project1.id, role:'lead')

collaborator2 = Collaborator.create(user_id: user1.id,project_id: project2.id, role:'lead')
collaborator3 = Collaborator.create(user_id: user2.id,project_id: project2.id, role:'user')

collaborator2 = Collaborator.create(user_id: user2.id,project_id: project3.id, role:'lead')


comment1 = ProjectComment.create(user_id: user1.id,project_id: project1.id, content:'THIS IS A COMMENT')
comment2 = ProjectComment.create(user_id: user2.id,project_id: project1.id, content:'THIS IS ALSO A COMMENT')

projectlike1 = ProjectLike.create(user_id: user1.id, project_id: project1.id)
projectlike2 = ProjectLike.create(user_id: user2.id, project_id: project1.id)

commentlike1 = CommentLike.create(user_id: user1.id, project_comment_id: comment1.id)
commentlike2 = CommentLike.create(user_id: user2.id, project_comment_id: comment2.id)

userlike1 = user1.likees << user2

projectMessage = ProjectMessage.create(user_id: user1.id, project_id: project1.id, content: "This is message hello")

