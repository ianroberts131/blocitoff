class ItemsController < ApplicationController
  
  def create
    @user = current_user
    @item = @user.items.new(item_params)

    if @item.save
      flash[:notice] = "Item saved successfully."
      redirect_to(authenticated_root_path)
    else
      flash[:alert] = "Items failed to save."
    end
  end

private
  def item_params
    params.require(:item).permit(:name)
  end

end