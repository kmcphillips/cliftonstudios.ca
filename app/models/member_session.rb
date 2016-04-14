class MemberSession < Authlogic::Session::Base

  logout_on_timeout true

  def to_key
    new_record? ? nil : [ self.send(self.class.primary_key) ]
  end

  # Rails 4.2 hacks for authlogic
  # https://github.com/binarylogic/authlogic/issues/432
  include ActiveModel::Naming
  def parents
    []
  end

  def name
    self.class.name
  end

end
