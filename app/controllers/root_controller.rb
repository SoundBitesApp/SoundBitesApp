class RootController < ApplicationController
  before_filter :authenticate_user!, only: [:soundcloud_post]
  def index
    
    @users = User.all
  end

  def about
  end

  def home
  end

  def profile
  end

  def soundcloud_post
    file = params[:file]
    picture = params[:picture]
    client = Soundcloud.new(:access_token => current_user.identities.first.auth_token)
    # upload an audio file
    #tags = params[:tags].split(",")
    #tags.collect(&:strip) # remove whitespace
    name = params[:name].strip
    description = params[:description]
    track = client.post('/tracks', :track => {
      :title => name,
      :asset_data => open(file),
      :description => description,
      :artwork_data => open(picture),
      :tag_list => params[:tags]
    })
    if track
      flash[:notice]="Succes! Track id: #{track.id}"
    else
      flash[:error]="Couldn't post track..."
    end
    respond_to do |format|
      format.html {redirect_to root_url}
    end
  
  end
end
