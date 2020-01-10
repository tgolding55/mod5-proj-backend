CommentLike.delete_all
ProjectComment.delete_all
ProjectLike.delete_all
ProjectMessage.delete_all
UserLike.delete_all
Collaborator.delete_all
Project.delete_all
User.delete_all


project1 = Project.create({title: "The Gist", description: "The Gist is an Etymology Infographic that shows the history and usage of words!", technologies_used: "React, Rails", collaborator_size_limit: 1, status: "Completed", github_link: '', timeframe: 3})
project2 = Project.create({title: "Miscue Studio", description: "An online tool for miscue analysis that primary school teachers can use to record the mistakes that children make when reading stories aloud.", technologies_used: "React, Rails", collaborator_size_limit: 1, status: "Completed", github_link: 'https://github.com/idmyn/miscue-studio-frontend', timeframe: 3})
project3 = Project.create({title: "Collabapage", description: "Collabapage is a collaboration site for developers to share their project ideas and collaborate with others by making use of the github API.", technologies_used: "React, Rails", collaborator_size_limit: 1, status: "Completed", github_link: 'https://github.com/tgolding55/mod5-proj-frontend', timeframe: 3})
project4 = Project.create({title: "The Broken Realm", description: "An interactive, storybook adventure/game that allows the user to choose a protagonist, make decisions to survive and explore a dark, dangerous fantasy world.", technologies_used: "React, Rails", collaborator_size_limit: 1, status: "Completed", github_link: 'https://github.com/Elwick1/Mod5-Project-Frontend', timeframe: 3})
project5 = Project.create({title: "R-T", description: "Artist centred platform where you can customise your own page and events that you create.", technologies_used: "React, Rails", collaborator_size_limit: 1, status: "Completed", github_link: 'https://github.com/LPrendergast/r-t-front', timeframe: 3})
project6 = Project.create({title: "Readable", description: "A social network for people that enjoy reading. Search for your favourite books, read reviews and track your progress.", technologies_used: "React, Rails", collaborator_size_limit: 1, status: "Completed", github_link: 'https://github.com/steve-alex/readable-react', timeframe: 3})
project7 = Project.create({title: "Upshot", description: "Upshot lets users create and organise events anywhere around the world. It can be useful for small office events and can be used among friends. It will save time from organising it over the phone.", technologies_used: "React, Rails", collaborator_size_limit: 1, status: "Completed", github_link: 'https://github.com/milenoss/upShot', timeframe: 3})
project8 = Project.create({title: "_Hygenik.com", description: "Hygenik.com takes your current location and plots the nearby food-serving on a map. You can view more detailed info about their hygiene, and blacklist sites that fall short.", technologies_used: "React, Rails", collaborator_size_limit: 1, status: "Completed", github_link: 'https://github.com/ck2e14/frontend5', timeframe: 3})
project9 = Project.create({title: "No Waste", description: "Users can create an advert saying they would like to donate food. Other users can see the advert, and accept to pick up the food; which they would then deliver to a food bank.", technologies_used: "React, Rails", collaborator_size_limit: 1, status: "Completed", github_link: 'https://github.com/hs21hs/mod5_frontend', timeframe: 3})
project10 = Project.create({title: "Fridger", description: "Fridger is there to take away the stress associated with not knowing what to prepare by helping discover new delicious recipes and limiting food waste by utilising food items available in your fridge.", technologies_used: "React, Rails", collaborator_size_limit: 1, status: "Completed", github_link: 'https://github.com/IlitaKu/Mod-5-Project-Front-End', timeframe: 3})
project11 = Project.create({title: "PerkPlace", description: "Companies can promote their perks and benefits and increase employer branding in the market. At the same time page visitors can find their perfect company as per their favourite perks etc.", technologies_used: "React, Rails", collaborator_size_limit: 1, status: "Completed", github_link: '', timeframe: 3})

user1 = User.create({username: "David Mynors", password: "123", bio:"I am david and this is a bio"})
user2 = User.create({username: "Tim Golding", password: "123", bio:"I am tim and this is a bio"})
user3 = User.create({username: "Tami Reichold", password: "123", bio:"I am tami and this is a bio"})
user4 = User.create({username: "Steve Alex", password: "123", bio:"I am steve and this is a bio"})
user5 = User.create({username: "Michael Williamson", password: "123", bio:"I am michael and this is a bio"})
user6 = User.create({username: "Haider Shah", password: "123", bio:"I am haider and this is a bio"})
user7 = User.create({username: "Kane Stephens", password: "123", bio:"I am kane and this is a bio"})
user8 = User.create({username: "Christopher Kennedy", password: "123", bio:"I am chris and this is a bio"})
user9 = User.create({username: "Ilita Kunelyte", password: "123", bio:"I am ilita and this is a bio"})
user10 = User.create({username: "Luke Prendergast", password: "123", bio:"I am luke and this is a bio"})
user11 = User.create({username: "Milen Khanal", password: "123", bio:"I am milen and this is a bio"})

collaborator1 = Collaborator.create(user_id: user7.id,project_id: project1.id, role:'lead')
collaborator2 = Collaborator.create(user_id: user1.id,project_id: project2.id, role:'lead')
collaborator3 = Collaborator.create(user_id: user2.id,project_id: project3.id, role:'lead')
collaborator4 = Collaborator.create(user_id: user5.id,project_id: project4.id, role:'lead')
collaborator5 = Collaborator.create(user_id: user10.id,project_id: project5.id, role:'lead')
collaborator6 = Collaborator.create(user_id: user4.id,project_id: project6.id, role:'lead')
collaborator7 = Collaborator.create(user_id: user11.id,project_id: project7.id, role:'lead')
collaborator8 = Collaborator.create(user_id: user8.id,project_id: project8.id, role:'lead')
collaborator9 = Collaborator.create(user_id: user6.id,project_id: project9.id, role:'lead')
collaborator10 = Collaborator.create(user_id: user9.id,project_id: project10.id, role:'lead')
collaborator11 = Collaborator.create(user_id: user3.id,project_id: project11.id, role:'lead')

comment1 = ProjectComment.create(user_id: user1.id,project_id: project1.id, content:'Love it')
comment2 = ProjectComment.create(user_id: user2.id,project_id: project2.id, content:'Nice')
comment3 = ProjectComment.create(user_id: user3.id,project_id: project3.id, content:'Very good')
comment4 = ProjectComment.create(user_id: user4.id,project_id: project4.id, content:'Wow')
comment5 = ProjectComment.create(user_id: user5.id,project_id: project5.id, content:'Generic Compliment')
comment6 = ProjectComment.create(user_id: user6.id,project_id: project6.id, content:'Cool')
comment7 = ProjectComment.create(user_id: user7.id,project_id: project8.id, content:'More generic compliment')
comment8 = ProjectComment.create(user_id: user8.id,project_id: project7.id, content:'Really good!')
comment9 = ProjectComment.create(user_id: user9.id,project_id: project9.id, content:'Im a fan')
comment10 = ProjectComment.create(user_id: user10.id,project_id: project10.id, content:'Very generic compliment')
comment11 = ProjectComment.create(user_id: user11.id,project_id: project11.id, content:'compliment')

projectlike1 = ProjectLike.create(user_id: user1.id, project_id: project1.id)
projectlike2 = ProjectLike.create(user_id: user2.id, project_id: project1.id)

commentlike1 = CommentLike.create(user_id: user1.id, project_comment_id: comment1.id)
commentlike2 = CommentLike.create(user_id: user2.id, project_comment_id: comment2.id)

userlike1 = user1.likees << user2

projectMessage = ProjectMessage.create(user_id: user1.id, project_id: project1.id, content: "This is message hello")

