# TL;DR: YOU SHOULD DELETE THIS FILE
#
# This file is used by web_steps.rb, which you should also delete
#
# You have been warned
module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /^the home\s?page$/
      '/'

    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    when /^the login page$/
      new_session_path
    when /^the User page for (.*)$/i
      user_path(User.find_by_email($1))
    when /^the User Edit page for (.*)$/i
      edit_user_path(User.find_by_email($1))
    when /^the Admin page$/
      admin_path
    when /^the admin edit page for (.+)$/i
      edit_admin_user_path(User.find_by_email($1))
    when /^the new admin date page$/
      new_admin_date_path
    when /^the admin dates page$/
      admin_dates_path
    when /^the new reservation page for (.+)$/i
      new_user_reservation_path(User.find_by_email($1))

    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
