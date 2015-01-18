# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
users = []

(1..5).each do |index|
    user = User.create({
        email: "user#{index}@email.com",
        password: 'password',
        firstname: Faker::Name.first_name,
        lastname: Faker::Name.last_name,
    })
    users << user
end

User.create({
  email: "admin@email.com",
  password: 'passw0rD',
  firstname: Faker::Name.first_name,
  lastname: Faker::Name.last_name,
  admin: 1
})

category = Category.create({
  name: "Category"
})

(1..5).each do |index|
  product = Product.create({
    title: Faker::Product.product_name,
    description: 'Description',
    price: 3*index,
    category_id: category.id,
    user_id: users.sample.id
  })

  (1..Random.rand(6)).each do |reviewindex|
    Review.create({
      content: Faker::Lorem.paragraphs(Random.new.rand(1..3)).join,
      rating: Random.new.rand(1..5),
      product_id: product.id,
      user_id: users.sample.id
    })
  end
end