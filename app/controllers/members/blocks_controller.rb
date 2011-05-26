class Members::BlocksController < BlocksController
  before_filter :require_member

  def bylaws
  end

  def emails
    @emails = Member.active.alphabetical.map(&:email)
  end

end

