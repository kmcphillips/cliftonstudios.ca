class Members::LinksController < ApplicationController
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
    @link = Link.new(params[:link)

    if @link.save
      redirect_to(member_links_path, :notice => 'Link was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    @link = Link.find(params[:id])

    if @link.update_attributes(params[:link])
      redirect_to(member_links_path, :notice => 'Link was successfully updated.') 
    else
      render :action => "edit"
    end
  end

  def destroy
    @link = Link.find(params[:id])
    @link.destroy

    redirect_to(members_links_path)
  end
end

