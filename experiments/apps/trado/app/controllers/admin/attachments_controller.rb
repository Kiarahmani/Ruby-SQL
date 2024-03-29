class Admin::AttachmentsController < ApplicationController
  before_action :authenticate_user!

  def show
    set_product
    set_attachment
    render json: { modal: render_to_string(partial: 'admin/products/attachments/preview') }, status: 200
  end

  def new 
    set_product
    new_attachment
    render json: { modal: render_to_string(partial: 'admin/products/attachments/modal', locals: { url: admin_product_attachments_path, method: 'POST' }) }, status: 200
  end

  def create
    set_product
    @attachment = @product.attachments.build(params[:attachment])
    if @attachment.save
      if @product.attachments.count == 1
          render json: { last_record: true, image: render_to_string(partial: 'admin/products/attachments/single') }, status: 200
      else
          render json: { last_record: false, image: render_to_string(partial: 'admin/products/attachments/single') }, status: 200
      end
    else
      render json: { errors: @attachment.errors.full_messages }, status: 422
    end
  end

  def edit
    set_product
    set_attachment
    render json: { modal: render_to_string(partial: 'admin/products/attachments/modal', locals: { url: admin_product_attachment_path, method: 'PATCH' }) }, status: 200
  end

  def update
    set_product
    set_attachment
    respond_to do |format|
      if @attachment.update(params[:attachment])
        format.js { render partial: 'admin/products/attachments/update', format: [:js] }
      else
        format.json { render json: { errors: @attachment.errors.full_messages }, status: 422 }
      end
    end
  end

  def destroy
    set_product
    set_attachment
    attachment_id = @attachment.id
    @attachment.destroy
    if @product.attachments.empty?
      render json: { last_record: true, html: '<div class="helper-notification"><p>You do not have any images for this product.</p><i class="icon-images"></i></div>' }, status: 200
    else
      render json: { last_record: false, attachment_id: attachment_id }, status: 200
    end
  end

  private

  def new_attachment
    @attachment = @product.attachments.build
  end

  def set_product
    @product = Product.find(params[:product_id])
  end

  def set_attachment
    @attachment = Attachment.find(params[:id])
  end
end
