class PlaylistsController < ApplicationController
  before_action :set_playlist, only: [:show, :edit, :update, :destroy, :remove_anime, :add_custom_music]

  def index
    authorize! :index, Playlist

    @playlists = current_user&.playlists || []
  end

  def show
    authorize! :index, @playlist
  end

  def new
    authorize! :new, Playlist

    @playlist = Playlist.new
  end

  def create
    @playlist = Playlist.new(playlist_params)
    @playlist.user = current_user

    authorize! :create, @playlist

    respond_to do |format|
      if @playlist.save
        format.html { redirect_to @playlist, notice: 'Playlist was successfully created.' }
        format.json { render :show, status: :created, location: @playlist }
      else
        format.html { render :new }
        format.json { render json: @playlist.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize! :destroy, @playlist

    @playlist.destroy
    respond_to do |format|
      format.html { redirect_to playlists_url, notice: 'Playlist was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def remove_anime
    authorize! :remove_anime, @playlist

    @anime = Anime.find(params[:anime_id])

    musics_to_delete = @playlist.musics_for_anime(@anime)

    if @playlist.musics.delete(musics_to_delete) && @playlist.animes.delete(@anime)    
      render 'replace_remove_button'
    else
      render action: :show
    end
  end

  def add_custom_music
    # TODO: actually add music to playlist and before music to db with custom type
    # TODO: parse this url
    @anime = Anime.find(params[:anime_id])
    youtube_video_id = Music.url_to_id(params[:youtube_video_url])
    @music = Music.where(youtube_video_id: youtube_video_id).first || Music.new(youtube_video_id: youtube_video_id, type: :custom, name: params[:youtube_video_url])
    if @music.anime.present? && @music.anime != @anime
      raise "This music can't be associated to this anime"
    end

    @music.anime = @anime
    @music.save!

    @playlist.musics << @music
    @playlist.save!

    render 'replace_custom_musics_form'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_playlist
      @playlist = Playlist.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def playlist_params
      params.require(:playlist).permit(:name)
    end
end
