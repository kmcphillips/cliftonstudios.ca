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
    elsif !params[:artist].blank? && Member.find_by_id(params[:artist])
      redirect_to artist_path(member)
    else
      redirect_to artsits_path
    end
  end

  def pictures
    if params[:browse] == "artist"
      picture = Picture.find_by_id(params[:id])
      member = picture.member || Member.find_by_id(params[:artist])

      if member
        redirect_to picture_path(member.permalink)
      else
        redirect_to pictures_path
      end
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

