module FormHelper
  def setup_post(post)
    3.times { post.sumpoints.build }
  end
end