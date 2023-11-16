# returns an array of strings expected to see
# for access level input (int)
#
# please see README.md for details on what 
# each access level entails 

def should_see_access(access_level_int)
    case access_level_int
    when 1
        [
            "'s Profile", # First Name
            "Bio",
            "Open Posts"
        ]
    when 2
        [
            # "Last Name", # for next iteration
            "Email",
            "Schedule"
        ]
    when 3
        [
            "✅", # Matched Study Groups
            "pending",
            # "Closed Study Groups", # for next iteration
        ]
    else
      raise "No mapping found for Access Level #{access_level_int.to_s}"
    end
end

def should_not_see_access(access_level_int)
    case access_level_int
    when 1
        [
            "Last Name",
            "Email",
            "Schedule",
            "✅",
            "pending",
            "Closed Study Groups"
        ]
    when 2
        [
            "✅",
            "pending",
            "Closed Study Groups"
        ]
    when 3
        [] # should be able to see everything
    else
      raise "No mapping found for Access Level #{access_level_int.to_s}"
    end
end