class V1::SearchMonitorsController < ApplicationController
  before_action :set_search_monitor, only: [:show, :update, :destroy, :result, :archive, :share,
                                            :add_favourite, :delete_favourite, :export]
  after_action :verify_authorized, except: [:delete_favourite, :add_favourite, :index_buyer]
  respond_to :json
  # GET /search_monitors
  def index
    @search_monitors = current_user.search_monitors
    authorize @search_monitors
    render json: @search_monitors
  end

  # GET /buyer_and_tender_list
  def index_buyer
    @buyers_and_tenders = []
    @search_monitors = current_user.search_monitors
    @search_monitors.each do |data|
      search_monitors = { id: "", buyer: "", tenders_count: "" }
      search_monitors[:id] = data.id
      search_monitors[:buyer] = data.buyer
      search_monitors[:tenders_count] = data.tenders_count
      @buyers_and_tenders.push search_monitors
    end
    render json: @buyers_and_tenders
  end

  # GET /search_monitors/1
  def show
    authorize @search_monitor
    render json: @search_monitor
  end

  def preview
    authorize SearchMonitor
    data, count = preview_search(search_monitor_params)
    render json: {
      data: data,
      count: count
    }, current_user: current_user
  end

  def all_monitor_result
    authorize SearchMonitor
    data, count = all_monitors_search
    data = data.map do |tender|
      # options = {serializer: TenderSerializer, scope: {current_user: current_user, search_monitor: @search_monitor} }
      # ActiveModelSerializers::SerializableResource.new(tender, options).serializer.attributes
      TenderSerializer.new(tender, current_user: current_user, search_monitor: nil).attributes
    end
    render json: {
      data: data,
      count: count
    }, current_user: current_user
  end

  def profile_monitor_result
    authorize SearchMonitor
    search_monitor = current_user.search_monitors.where(monitor_type: :profile)
    results = search_monitor.results(sort_by: params[:sort_by], sort_direction: params[:sort_direction])
    data, count = serialize_core_tenders_search(results)
    render json: {
      data: data,
      count: count
    }, current_user: current_user
  end

  def compete_monitor_result
    authorize SearchMonitor
    result = current_user.tenders.uniq.sort_by(search_monitor_sort_params)
    data, count = result.my_paginate(paginate_params), result.count
    render json: {
      data: data,
      count: count
    }, current_user: current_user
  end

  def favourite_monitor_result
    authorize SearchMonitor
    favourite_tenders = current_user.favourite_tenders
    favourite_tenders = favourite_tenders.sort_by(search_monitor_sort_params)
    data, count = favourite_tenders.my_paginate(paginate_params), favourite_tenders.count
    render json: {
      data: data,
      count: count
    }, current_user: current_user
  end

  def share
    render json: nil
  end

  def archive
    authorize SearchMonitor
    if @search_monitor.update(is_archived: true)
      render json: nil, status: :ok
    else
      render json: @search_monitor.errors, status: :unprocessable_entity
    end
  end

  def delete_favourite
    current_user.favourite_monitors.where(search_monitor: @search_monitor).delete_all
    
    render json: @search_monitor, status: :ok
  end

  def add_favourite
    current_user.favourite_monitors.find_or_create_by search_monitor: @search_monitor
    
    render json: @search_monitor, status: :ok
  end

  def result
    authorize SearchMonitor
    results = @search_monitor.results(sort_by: params[:sort_by], sort_direction: params[:sort_direction])
    data, count = serialize_core_tenders_search(results)
    save_tender_count(@search_monitor,count)
    render json: {
      data: data,
      count: count
    }, current_user: current_user
  end

  # POST /search_monitors
  def create
    @search_monitor = current_user.search_monitors.new(search_monitor_params)
    authorize @search_monitor
    if @search_monitor.save
      render json: @search_monitor, status: :created
    else
      render json: @search_monitor.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /search_monitors/1
  def update
    authorize @search_monitor
    if @search_monitor.update(search_monitor_params)
      render json: @search_monitor
    else
      render json: @search_monitor.errors, status: :unprocessable_entity
    end
  end

  # DELETE /search_monitors/1
  def destroy
    authorize @search_monitor
    @search_monitor.destroy
  end

  def export
    authorize SearchMonitor
    SearchMonitor::MonitorExport.perform_later @search_monitor
  end


  private
    def save_tender_count(monitor,count)
      monitor.tenders_count = count
      monitor.save
    end

    def serialize_core_tenders_search(results)
      tenders = results.page(params[:page]).per(params[:page_size]).objects.map do |tender|
        TenderSerializer.new(tender, current_user: current_user, search_monitor: @search_monitor).attributes
      end
      return tenders, results.count
    end

    def all_monitors_search
      monitors = current_user.search_monitors
      ids = []
      monitors.each do |e|
        ids += e.results.map {|e| e.attributes['id']} .map(&:to_i) 
      end
      ids.uniq!
      results = Core::Tender.where(id: ids)
      if params[:sort_field] && params[:sort_direction]
        results = results.order(params[:sort_field].to_sym => params[:sort_direction].to_sym)
      else
        results = results.order(created_at: :desc)
      end
      [results.my_paginate(paginate_params), results.count]
    end

    def preview_search(search_monitor_params)
      tender_title = search_monitor_params[:tenderTitle]
      tender_keywords = search_monitor_params[:keywordList]
      tender_value_from = search_monitor_params[:valueFrom]
      tender_value_to = search_monitor_params[:valueTo]
      tender_countries = search_monitor_params[:countryList]
      tender_buyers = search_monitor_params[:buyer]
      tender_statuses = search_monitor_params[:status]
      tender_sort_by = search_monitor_params[:sort_by]
      tender_sort_direction = search_monitor_params[:sort_direction]
      tender_submission_date_from = search_monitor_params[:submission_date_from]
      tender_submission_date_to = search_monitor_params[:submission_date_to]

      cur_page = params[:page]
      page_size = params[:page_size]
    
      results = Core::Tender.search(
        tender_title: tender_title,
        tender_keywords: tender_keywords,
        tender_value_from: tender_value_from,
        tender_value_to: tender_value_to,
        tender_countries: tender_countries,
        tender_buyers: tender_buyers,
        tender_statuses: tender_statuses,
        tender_submission_date_to: tender_submission_date_to,
        tender_submission_date_from: tender_submission_date_from,
        tender_sort: {
            sort_by: tender_sort_by,
            sort_direction: tender_sort_direction
          }
        )
      tenders = results.page(cur_page).per(page_size).objects.map do |tender|
        # options = {serializer: TenderSerializer, scope: {current_user: current_user, search_monitor: @search_monitor} }
        # ActiveModelSerializers::SerializableResource.new(tender, options).serializer.attributes
        TenderSerializer.new(tender, current_user: current_user, search_monitor: @search_monitor).attributes
      end
      return tenders, results.count
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_search_monitor
      @search_monitor = SearchMonitor.find(params[:id])
    end

    def paginate_params
      params.permit(:page, :page_size)
    end

    # Only allow a trusted parameter "white list" through.
    def search_monitor_params
      params.permit(:title, :tenderTitle, :valueFrom, :valueTo, :buyer, :sort_by, :sort_direction, :submission_date_to, :submission_date_from, codeList:[], countryList:[], statusList:[], keywordList:[], status: [])
    end
    def search_monitor_sort_params
      params.permit(:sort_by, :sort_direction)
    end
end
