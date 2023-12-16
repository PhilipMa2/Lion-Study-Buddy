# returns an array of strings expected to see
# for access level input (int)
#
# please see README.md for details on what 
# each access level entails 

def should_see_access(access_level_int)
    case access_level_int
    when 1
        [
            "'s Profile",
            "Bio"   
        ]
    when 2
        [
            "'s Profile",
            "Bio",
            "Email"
        ]
    when 3
        [
            "'s Profile",
            "Bio",
            "Email",
            "Groups Created",
            "Groups Applied",
            "Schedule"
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