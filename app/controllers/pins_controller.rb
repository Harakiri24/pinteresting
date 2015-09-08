class PinsController < ApplicationController
  before_action :set_pin, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  def index
    @pins = Pin.all.order("created_at DESC").paginate(:page => params[:page], :per_page => 6)
  end

  def show
  end

  def new
    @pin = current_user.pins.build
  end

  def edit
  end

def create
  @pin = Pin.new(pin_params)
  @pin.user_id = current_user.id
        if @pin.save
       redirect_to @pin, alert: 'Dein Pin wurde erstellt.'
      else
        render :new
      end
end

  #def create
    #@pin = current_user.pins.build(pin_params)
    #  if @pin.save
    #   redirect_to @pin, alert: 'Dein Pin wurde erstellt.'
    #  else
    #    render :new
    #  end
 # end

  def update
      if @pin.update(pin_params)
        redirect_to @pin, alert: 'Dein Pin wurde bearbeitet.'
      else
        render :edit
      end
  end

  def destroy
    @pin.destroy
      redirect_to pins_url, alert: 'Dein Pin wurde gelöscht.'
    end
  end

  private
    def set_pin
      @pin = Pin.find(params[:id])
    end

    def correct_user
      @pin = current_user.pins.find_by(id: params[:id])
      redirect_to pins_path, alert: 'Keine Berechtigung den Pin zu bearbeiten' if @pin.nil?
    end

    def pin_params
      params.require(:pin).permit(:description, :image, :content_type)
    end

