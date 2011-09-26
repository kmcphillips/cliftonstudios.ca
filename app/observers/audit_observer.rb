class AuditObserver < ActiveRecord::Observer
  observe :post, :event, :member, :picture, :block, :link, :executive

  def after_save(object)
    audit = Audit.new :auditable => object, :action => (object.new_record? ? "create" : "update"), :member => MemberTracker.current, :details => object.changes
    audit.save
  end

end

