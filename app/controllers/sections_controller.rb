class SectionsController < ApplicationController
  def index
    @sections = Section.includes(:forums).all.order(:rank);
  end
  
  def show
    @section = Section.includes(:forums).find(params[:id]);
  end
  
  def new
    #placeholder
  end
  
  def create
    #placeholder
  end
  
  def edit
    #placeholder
  end
  
  def update
    #placeholder
  end
  
  def destroy
    #placeholder
  end
end
