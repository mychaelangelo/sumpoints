class FollowMailer < ActionMailer::Base
  default from: "app27182687@heroku.com"

  def new_sumpoint(user, post, sumpoint)

    # New Headers
    headers["Message-ID"] = "<sumpoints/#{sumpoint.id}@your-app-name.example>"
    headers["In-Reply-To"] = "<post/#{post.id}@your-app-name.example>"
    headers["References"] = "<post/#{post.id}@your-app-name.example>"

    @user = user
    @post = post
    @sumpoint = sumpoint

    mail(to: user.email, subject: "New SumPoint on #{post.title}")
  end

end
