class ToggleLikeService
  def initialize(likeable, user)
    @likeable = likeable
    @user = user
  end

  def call!
    @like = @likeable.likes.find_by(user_id: @user.id)

    return like if @like.nil?

    dislike
  end

  def self.call!(likeable, user)
    new(likeable, user).call!
  end

  private

  def like
    Like.create!(user: @user, likeable: @likeable)
  end

  def dislike
    @like.destroy
  end
end
