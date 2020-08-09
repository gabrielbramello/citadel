module Meta
  class FormatsController < MetaController
    skip_before_action :require_any_admin_permissions, only: [:show]
    skip_before_action :require_meta, only: [:show]

    before_action except: [:index, :new, :create] do
      @format = Format.find(params[:id])
    end

    def index
      @formats = Format.all
    end

    def new
      @format = Format.new
    end

    def create
      @format = Format.new(format_params)

      if @format.save
        redirect_to meta_format_path(@format)
      else
        render :new
      end
    end

    def show
    end

    def edit
    end

    def update
      if @format.update(format_params)
        redirect_to meta_format_path(@format)
      else
        render :edit
      end
    end

    def destroy
      if @format.destroy
        redirect_to meta_game_path(@format.game)
      else
        render :edit
      end
    end

    private

    def format_params
      params.require(:format_).permit(:game_id, :player_count, :name, :description)
    end
  end
end
