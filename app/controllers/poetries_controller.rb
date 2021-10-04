class PoetriesController < AuthorizationController
  before_action :set_poetry, only: [:show, :destroy]
  before_action :logged_in?, except: [:index, :show, :poetries]
  # GET /poetries
  def index
    @poetries = Poetry.all
    render json: @poetries
  end

  def poetries
    @poetries = Poetry.all.with_attached_featured_image.order(:id).map do |ad|
      {        
        id: "#{ad.id}",
        # image: ad.image,        
        title: ad.title,
        body: ad.body,
        user: ad.user.name,
        featured_image: url_for(ad.featured_image),
        key: ad.featured_image.key       
      }
    end

    render json: { poetries: @poetries }
  end

  # GET /poetries/1
  def show
    poetry = {
        id: @poetry.id,
        title: @poetry.title,
        body: @poetry.body,
        user_id: @poetry.user.id,
        user_name: @poetry.user.name,
        featured_image: @poetry.featured_image,
        key: @poetry.featured_image.key 
    }
    render json: poetry
  end

  # POST /poetries
  def create

    @poetry = Poetry.new(featured_image: params[:featured_image], body: params[:body], title: params[:title])
    @poetry.user = current_user

    if @poetry.save
      puts "dentro do save"
      puts @poetry  
      render json: @poetry, status: :created, location: @poetry
    else
      puts "fora do save"
      puts @poetry.errors
      render json: @poetry.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /poetries/1
  def update
    @poetry = Poetry.find(params[:id])
    #byebug
    if @poetry.update(body: params[:body], title: params[:title])
      puts "Entrou"
      render json: @poetry
    else
      puts "Não Entrou"
      render json: @poetry.errors, status: :unprocessable_entity
    end
  end

  # DELETE /poetries/1
  def destroy
    @poetry.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_poetry
      @poetry = Poetry.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def poetry_params
      params.require(:poetry).permit(:title, :body, :featured_image)
    end
end
