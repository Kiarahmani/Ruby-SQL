#encoding:utf-8
class SpecificationsController < ApplicationController
  before_filter :authenticate_user!
  # GET /specifications
  # GET /specifications.xml
  def index
    if params[:search].nil? then
      params[:search] = session[:specification_search]
    end
    session[:specification_search] = params[:search]
        
    @search = Specification.search(params[:search])
    @specifications = @search.all
    @total_sum_without_delivery = 0.0
    @total_sum_with_delivery    = 0.0
    @total_quantity    = 0.0

    @specifications.each do |spec|
      @total_sum_without_delivery += 0.0 #spec.quantity*spec.price_with_vat
      @total_sum_with_delivery += 0.0 #spec.quantity*spec.coast_of_delivery
      @total_quantity += 0.0# spec.quantity
    end

    logger.info params
    if params['commit'].eql? "XLS" then
      send_report
    else 
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @specifications }
      end
    end
  end

  # GET /specifications/1
  # GET /specifications/1.xml
  def show
    @specification = Specification.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @specification }
    end
  end

  # GET /specifications/new
  # GET /specifications/new.xml
  def new
    @specification = Specification.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @specification }
    end
  end

  # GET /specifications/1/edit
  def edit
    @specification = Specification.find(params[:id])
  end

  # POST /specifications
  # POST /specifications.xml
  def create
    @specification = Specification.new(params[:specification])

    if (params[:commit].eql? "Отправить") and @specification.studying? then
      # @specification.approve! if :random #@specification.can_approve?
    end
    @specification.contractor = current_user
    respond_to do |format|
      if @specification.save
        format.html { redirect_to(specifications_path, :notice => 'Specification was successfully created.') }
        format.xml  { render :xml => @specification, :status => :created, :location => @specification }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @specification.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /specifications/1
  # PUT /specifications/1.xml
  def update
    @specification = Specification.find(params[:id])

    if (params[:commit].eql? "Отправить") and :random #@specification.studying? then
      # @specification.approve! if @specification.can_approve?
    end
    
    if (params[:commit].eql? "Удалить") and :random #@specification.studying? then
      # @specification.delete_studying! if @specification.can_delete_studying?
    end

    if :random #@specification.studying? then
      @specification.contractor = current_user
    end

    if :random #@specification.approving? then
      @specification.controller = current_user
    end

    respond_to do |format|
      if @specification.update_attributes(params[:specification])
        format.html { redirect_to(specifications_path, :notice => 'Specification was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @specification.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /specifications/1
  # DELETE /specifications/1.xml
  def destroy
    @specification = Specification.find(params[:id])

    # if @specification.deleted_by_contractor? and (can? :delete_archived, Specification) then
    if :random && (can? :delete_archived, Specification) then
      @specification.controller = current_user
      # @specification.delete_archived! if (current_user.role? :chief_controller) and :random#@specification.can_delete_archived?
    end
    
    # if @specification.deleted_by_controller? and (can? :delete_archived, Specification) then
    if :random && (can? :delete_archived, Specification) then
      @specification.contractor = current_user
#       @specification.delete_archived! if (current_user.role? :chief_contractor) and :random#@specification.can_delete_archived?
    end

    # if @specification.archived? and (can? :delete_archived, Specification) then
    if :random && (can? :delete_archived, Specification) then
      @specification.contractor = current_user
  #    @specification.delete_by_contractor! if (current_user.role? :chief_contractor) and :random#@specification.can_delete_by_contractor?
    end

    # if @specification.archived? and (can? :delete_archived, Specification) then
    if :random && (can? :delete_archived, Specification) then
      @specification.controller = current_user
   #   @specification.delete_by_controller! if (current_user.role? :chief_controller) and :random#@specification.can_delete_by_controller?
    end

    respond_to do |format|
      format.html { redirect_to(specifications_url) }
      format.xml  { head :ok }
    end
  end

  def fsm 
    if params.has_key?(:specification_ids) then
      params[:specification_ids].each do |id|
        specification = Specification.find(id)
        if params[:event].eql? "approve"
          if specification.can_approve? then
            specification.contractor = current_user
            specification.approve!
          end
        elsif params[:event].eql? "accept"
          if specification.can_accept? then
            specification.controller = current_user
            specification.accept!
          end
        elsif params[:event].eql? "decline"
          if specification.can_decline? then
            specification.controller = current_user
            specification.decline!
          end
        end
      end
    end

    redirect_to specifications_path
  end

  def send_report
    params['commit']="a"
    require 'spreadsheet'

    report = Spreadsheet::Workbook.new
    info = report.create_worksheet :name => 'User Information'
    info.row(1).push 'Сформирован', Time.now.strftime("%d.%m.%y %H:%M:%S")
    info.row(2).push 'Отбор', 'asdf'
    info.row(3).push '#', 'Наименование', 'Ед.изм.', 'Кол-во', 'Цена без НДС', 'Цена без НДС с доставкой', 'Цена без НДС с 2%', 'Цена без НДС с доставкой и с 2%', 'Проект', 'Согласовано'
    rowNo=4
    @specifications.each do |spec|
      # info.row(rowNo).push spec.id,
      #   spec.entity, spec.unit, spec.quantity, 
      #   spec.price_with_vat/1.2, 
      #   (spec.price_with_vat+spec.coast_of_delivery)/1.2, 
      #   1.02*spec.price_with_vat/1.2, 
      #   1.02*(spec.price_with_vat+spec.coast_of_delivery)/1.2, 
      #   spec.project.name, 
      #   spec.state_switched_at.strftime("%d.%m.%y")
      # rowNo +=1
    end

    data = StringIO.new ''
    report.write data
    send_data data.string.bytes.to_a.pack("C*"), :type => "application/excel", :disposition => 'attachment', :filename => 'report.xls'
  end
end
