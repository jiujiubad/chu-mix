namespace :post do
  # 跳过回调：<http://thelazylog.com/skip-activerecord-callbacks>
  task all: [
              :create_users_and_posts
            ]

  ## Ajax交互式网页应用-文章点赞网
  task create_users_and_posts: :environment do
    puts "Start create_users_and_posts"
    User.create!(email: "chu@example.com", password: "chu@example.com")

    10.times do
      User.create!(email: Faker::Internet.email, password: Faker::Internet.password(8))
    end

    50.times do
      Post.create!( content: Faker::Lorem.paragraph, user_id: User.all.sample.id )
    end
  end
end
