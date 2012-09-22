# I should probably replace this with paper_trail

module Audited

  def self.included(base)
    base.extend ClassMethods
    base.instance_eval do

      after_save :create_audit

    end
  end

  module ClassMethods
  end

  protected

  def create_audit
    unless self.is_a?(Member) && (self.changes.keys - ["perishable_token", "last_request_at", "crypted_password", "updated_at", "password_salt", "current_login_at", "persistence_token", "login_count", "last_login_at", "password_configured"]).size == 0
      audit = Audit.new :auditable => self, :action => (self.new_record? ? "create" : "update"), :member => MemberTracker.current, :details => self.changes
      audit.save
    end

    true
  end

end
