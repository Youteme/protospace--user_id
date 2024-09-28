class PrototypesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @comment = Comment.new
    @prototype = Prototype.find(params[:id])
    @comments = @prototype.comments.includes(:user)
    @user = @prototype.user
  end

  def edit
    @prototype = Prototype.find(params[:id])
  end

  def update
    @prototype = Prototype.find(params[:id])
    if @prototype.update(prototype_params)
      redirect_to prototype_path(@prototype)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @prototype = Prototype.find(params[:id])
    @prototype.comments.destroy_all
    @prototype.destroy

    redirect_to  prototypes_path(@prototype)
  end

  private

  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image, ).merge(user_id: current_user.id)
  end

  def comment_params
    params.require(:comment).permit(:content)
  end

  def correct_user
    @prototype = Prototype.find(params[:id])
    unless @prototype.user == current_user
      redirect_to root_path, alert: "You are not authorized to edit this prototype."
    end
  end
end