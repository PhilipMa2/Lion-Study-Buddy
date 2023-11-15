def path_to(page_name)
    base_url = "http://127.0.0.1:3000"

    case page_name
    when 'home'
        base_url + '/'
    when 'login'
        base_url + '/login'
    when 'logout'  # Add this case
        base_url + '/logout'
    when 'profile'
        base_url + '/profile'
    when 'new post'
        base_url + '/posts/new'
    when /^specified post (\d+)$/  # Adjust this regex
        base_url + "/posts/#{$1}"
    when 'study group post'  
        base_url + "/posts/1" # TODO: adjust variable
    when 'unmatched_student'
        base_url + "/students/4" # Dave is not matched with Frank
    when 'unmatched_post'
        base_url + "/posts/4" # Frank is not in Dave's study group
    else
      raise "No mapping found for #{page_name}"
    end
end