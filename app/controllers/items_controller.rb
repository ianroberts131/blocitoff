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
  
  def destroy
    @item = Item.find(params[:id])
    
    if @item.destroy
      flash[:notice] = "Item was deleted successfully."
    else
      flash[:alert] = "There was an error deleting the item."
    end
    
    respond_to do |format|
      format.html
      format.js
    end
  end

private
  def item_params
    params.require(:item).permit(:name)
  end

end