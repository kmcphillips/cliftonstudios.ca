require 'authlogic/test_case'
include Authlogic::TestCase

def member_login
  activate_authlogic
  MemberSession.create(FactoryGirl.create(:member)).member
end
