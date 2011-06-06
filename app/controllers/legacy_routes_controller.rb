class LegacyRoutesController < ApplicationController

  def news
    redirect_to root_path
  end

  def events
    redirect_to events_path
  end

  def about
    redirect_to about_path
  end

  def login
    redirect_to login_path
  end

  def artists
    if !params[:name].blank? && member = Member.find_by_legacy_name(params[:name])
      redirect_to artist_path(member)
    else
      redirect_to artsits_path
    end
  end

  def pictures
    case params[:browse]
      when "artist"
        picture = Picture.find_by_id(params[:id])
        member = picture.member || Member.find_by_id(params[:artist])

        raise "TODO: pictures legacy routes"
 
      when "studio"
        raise "TODO: pictures legacy routes"

      when "all"
        raise "TODO: pictures legacy routes"

      else
        redirect_to pictures_path
    end
  end

  def default
    if params[:page] =~ /^m_/
      redirect_to login_path
    else
      redirect_to root_path
    end
  end

end

