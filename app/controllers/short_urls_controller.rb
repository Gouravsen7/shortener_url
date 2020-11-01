class ShortUrlsController < ApplicationController

  before_action :set_url, only: [:show, :redirect]

  def index
    @urls = ShortUrl.all.order(click_count: :desc, updated_at: :desc).first(100)
  end

  def new
    @url = ShortUrl.new
  end
  
  def create
    @url = ShortUrl.find_or_initialize_by(short_url_params)
    if @url.save
      redirect_to short_url_path(@url.slug)
    else
      flash[:error] = @url.errors.full_messages
      redirect_to new_short_url_path
    end
  end
  
  def redirect
    @url.update(click_count: @url.click_count + 1)
    redirect_to @url.sanitize
  end

  def show
  end
  
  private
    def short_url_params
      params.require(:short_url).permit(:original_url)
    end

    def set_url
      @url = ShortUrl.find_by(slug: params[:short_url] || params[:id])
      render :file => "#{Rails.root}/public/404", :layout => false, :status => :not_found unless @url
    end
end
