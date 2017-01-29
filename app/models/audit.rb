class Audit < ActiveRecord::Base
  serialize :details

  belongs_to :auditable, :polymorphic => :true
  belongs_to :member

  validates :action, :inclusion => ["update", "create"]

  scope :sorted, -> { order("created_at DESC") }

  def action_verb
    action + "d"
  end

  def self.recent(limit=4)
    find_by_sql("select a1.auditable_type, a1.auditable_id, a1.member_id, a1.action, a1.created_at from audits a1 left outer join audits a2 on (a1.auditable_id = a2.auditable_id and a1.auditable_type = a2.auditable_type and a1.member_id = a2.member_id and a1.created_at < a2.created_at) where a2.auditable_id is null order by a1.created_at desc limit #{limit}")
  end

end

