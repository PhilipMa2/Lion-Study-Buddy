def path_to(page_name)
    base_url = "http://localhost:#{ENV['APP_PORT'] || 3000}"

    case page_name
    when 'home'
        base_url + '/'
    when 'login'
        base_url + '/login'
    when 'profile'
        base_url + '/profile'
    when 'new post'
        base_url + '/posts/new'
    when "specified post #{id}"
        base_url + "/posts/#{id}"
    else
      # Default or error case, you can also raise an error here
      raise "No mapping found for #{page_name}"
    end
end