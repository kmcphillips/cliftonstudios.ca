class AuditObserver < ActiveRecord::Observer
  observe :post, :event, :member, :picture, :block, :link, :executive

  def after_save(object)
    # Do not audit Authlogic updates. These happen on logins and password changes, among other things.
    unless object.is_a?(Member) && (object.changes.keys - ["last_request_at", "crypted_password", "updated_at", "password_salt", "current_login_at", "persistence_token", "login_count", "last_login_at", "password_configured"]).size == 0
      audit = Audit.new :auditable => object, :action => (object.new_record? ? "create" : "update"), :member => MemberTracker.current, :details => object.changes
      audit.save
    end
  end

end

