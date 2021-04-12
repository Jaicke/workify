module Student::UsersHelper
  def url_for_profile_image(user)
    if user.avatar.attached?
      url_for(user.avatar)
    else
      "profile-placeholder.png"
    end
  end
end
