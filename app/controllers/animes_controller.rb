class AnimesController < ApplicationController
  before_action :set_anime, only: [:add_to_playlist]

  before_action :set_playlist, only: [:search, :index, :add_to_playlist]

  def index
    authorize! :index, @playlist

    # for the sake of safety do a to_i
    @animes = Anime.page(params[:page].to_i)
  end

  # Bad do jquery instead
  # Maybe not
  # Maybe just check if get or post !
  def search
    authorize! :search, @playlist

    if request.get?
      @animes = []
      return
    end

    # for the sake of safety cut query
    @query = params[:query]&.first(100)
    @animes = AnimeSearch.fuzzy_matching(@query)
  end

  # POST /anime/1/add_to_playlist
  def add_to_playlist
    authorize! :add_to_playlist, @playlist

    # No validation, weird
    @playlist.animes << @anime

    # TODO: random pick instead when we will have more musics per anime
    @playlist.musics += @anime.musics

    render 'replace_button'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_anime
      @anime = Anime.find(params[:id])
    end

    def set_playlist
      @playlist = Playlist.find(params[:playlist_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def anime_params
      params.fetch(:anime, {})
    end
end
