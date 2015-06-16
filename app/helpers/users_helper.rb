module UsersHelper

  def profiles_path(user=nil)
    if user.nil?
      "/users"
    else
      "/profiles/#{user.username}"
    end
  end

end
