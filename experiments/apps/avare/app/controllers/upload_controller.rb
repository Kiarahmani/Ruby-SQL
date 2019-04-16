class UploadController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    authorize! :manage, Upload     
    if params[:search].nil? then
      params[:search] = session[:upload_search]
    end
    session[:upload_search] = params[:search]
    @search = Upload.search(params[:search])
    @uploads = @search.all
  end

  def upload_file
    authorize! :manage, Upload      
    if not params[:datafile].nil? then
      # tmp = params[:datafile].tempfile
      # Upload.ImportFromXLS tmp, current_user
      # FileUtils.rm tmp
    end
    redirect_to upload_index_path
  end

  def handle
    authorize! :manage, Upload   
    if params.has_key?(:upload_ids) then
      params[:upload_ids].each do |id|
        upload_item = Upload.find(id)
        if params[:method].eql? "import" then
          Specification.create! :entity => upload_item.entity,
            :quantity => upload_item.quantity,
            :unit => upload_item.unit,
            :price_with_vat => upload_item.price_with_vat,
            :coast_of_delivery => upload_item.coast_of_delivery,
            :supplier => upload_item.supplier,
            :contractor => upload_item.contractor,
            :project_id => params[:project_id],
            :category_id => params[:category_id]
        end
        upload_item.delete 
      end
    end
    redirect_to upload_index_path
  end
end
