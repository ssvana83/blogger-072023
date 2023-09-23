# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

u= User.create(username: 'stacy', email: 'stacy@gmail.com', password: "Password")

p1 = Post.create(user_id: u.id, title: "Best restaurants in Nashville", content: "The must visit places to eat in my opinion" )
p2 = Post.create(user_id: u.id, title: "Concerts coming to Nashville in August", content: "New concert schedule was posted and it looks like a good month to visit!" )


# Comment.create(rating: 6, content: "Cant wait to try the BBQ place you mentioned!", post: p1) instead write;
p1.comments.create(rating: 6, content: "Cant wait to try the BBQ place you mentioned!")
p1.comments.create(rating: 3, content: "I wish you suggested more vegetarian options")

# # Comment.create(rating: 8, content: "I have been dying to see Luke Bryan live!", post: p2) instead write;
p2.comments.create(rating: 6, content: "I have been dying to see Luke Bryan live!")
p2.comments.create(rating: 3, content: "Bummer, I wont be there when The Dixie Chicks play!")

# Comment.create(rating: 6, content: "Cant wait to try the BBQ place you mentioned!", user_id: u.id, post: p1.id)