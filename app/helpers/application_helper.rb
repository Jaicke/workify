module ApplicationHelper
  def format_phone(number)
    "(#{number[0,2]}) #{number[3]} #{number[3,4]}-#{number[7,10]}"
  end

  def current_user_like_icon(likeable)
    like = Like.find_by(
      user_id: @current_user.id,
      user_type: @current_user.class.name,
      likeable_id: likeable.id,
      likeable_type: likeable.class.name
    )

    return icon("far", "heart", class: "like-heart") if like.nil?

    icon("fas", "heart", class: "like-heart")
  end
end
