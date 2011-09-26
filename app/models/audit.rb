class Audit < ActiveRecord::Base
  serialize :details

  belongs_to :auditable, :polymorphic => :true
  belongs_to :member

  validates :action, :inclusion => ["update", "create"]

  scope :recent, lambda{|limit| order("created_at DESC").limit(limit) }

  def action_verb
    action + "ed"
  end

end

