module MemberTracker
  def self.current
    Thread.current[:current_member]
  end
 
  def self.current=(member)
    Thread.current[:current_member] = member
  end
end

