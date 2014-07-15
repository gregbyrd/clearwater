
# copied from The Rails 4 Way (14.3.6)
# NOTE: changed name to :auth_permit to avoid conflict with Pundit rpsec

# NOTE: Deprecation warning with pundit's rspec.rb.
# To remove, replace config.include at end of file with this:
# RSpec.configure do |config|
#  config.include Pundit::RSpec::PolicyExampleGroup, :type => :policy, 
#     :file_path => /spec\/policies/
#end


RSpec::Matchers.define :auth_permit do |action|
  match do |policy|
    policy.public_send("#{action}?")
  end

  failure_message do |policy|
    "#{policy.class} does not permit #{action} on #{policy.record} for #{policy.user.request}."
  end

  failure_message_when_negated do |policy|
    "#{policy.class} does not forbid #{action} on #{policy.record} for #{policy.user.request}."
  end
end


