class Members::LinksController < ApplicationController
  before_filter :require_member

  def index
    @links = Link.sorted
  end

  def new
    @link = Link.new
  end

  def edit
    @link = Link.find(params[:id])
  end

  def create
    @link = Link.new(params[:link])

    if @link.save
      redirect_to(members_links_path, :notice => 'Link was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    @link = Link.find(params[:id])

    if @link.update_attributes(params[:link])
      redirect_to(members_links_path, :notice => 'Link was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @link = Link.find(params[:id])
    @link.destroy

    redirect_to(members_links_path)
  end

  def sort
    if params[:link].try(:is_a?, Array)
      ActiveRecord::Base.transaction do
        params[:link].each_with_index do |id, index|
          ActiveRecord::Base.connection.execute("UPDATE links SET sort_order = #{index + 1} WHERE id = #{id.to_i}")
        end
      end
    end

    render :nothing => true
  end

end

