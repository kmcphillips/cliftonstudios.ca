class Members::BlocksController < BlocksController
  before_filter :require_member, except: [:create, :index, :mail_queue, :audits]
  before_filter :require_admin_member, only: [:create, :index, :mail_queue, :audits]

  def index
    @about = Block.find_by_label :about
    @availability = Block.find_by_label :availability
  end

  def create  # update without ID
    @about = Block.find_by_label :about
    @availability = Block.find_by_label :availability

    @about.body = params[:about]
    @about.image = params[:image]
    @availability.body = params[:availability]

    if [@about.valid?, @availability.valid?].all?
      @about.save
      @availability.save
      redirect_to members_blocks_path, :notice => "Studio about section updated."
    else
      flash[:error] = ["There was an error saving.", @about.errors.full_messages, @availability.errors.full_messages].flatten.to_sentence
      render :index
    end
  end

  def emails
    @emails = Member.public.active.alphabetical.map(&:email)
    @phone = Member.public.active.alphabetical.contact_by_phone
  end

  def mail_queue
    @emails = PendingEmail.incomplete
  end

  def audits
    @audits = Audit.paginate(pagination_params(:order => "created_at DESC", :per_page => 20))
  end

end

