class Api::V1::ProductController < ApplicationController
  def index
    if params[:id]
      record = Product.where(id: params[:id]).order(name: :asc)
      response.headers["Access-Control-Allow-Origin"] = "*"
      response.headers["Access-Control-Expose-Headers"] = "X-Total-Count"
      response.headers["X-Total-Count"] = record.count
      render json: record.limit(10)
    else
      start_param = params["_start"].to_i
      end_param = params["_end"].to_i
      sort_param = params["_sort"]
      order_param = params["_order"]

      per_page = end_param - start_param || 1
      page = (start_param / per_page) + 1
      q = Product.ransack(name_or_slug_cont: params[:q])
      result = q.result(distinct: true)

      collection = result.order("#{sort_param} #{order_param}").limit(per_page).offset(start_param)
      pagy = Pagy.new(count: result.count, page: page, items: per_page)
      response.headers["Access-Control-Allow-Origin"] = "*"
      response.headers["Access-Control-Expose-Headers"] = "X-Total-Count"
      response.headers["X-Total-Count"] = pagy.count
      render json: collection
    end
  end

  def show
    record = Product.find(params[:id])
    render json: record
  end

  def update
    if record = Product.find(params[:id])
      record.update(record_params)
      render json: record
    else
      render json: { message: "Not found" }, status: :not_found
    end
  end

  def create
    if record = Product.create(record_params)
      render json: record
    else
      render json: record.errors, status: :bad_request
    end
  end

  def destroy
    if record = Product.find(params[:id])
      record.delete
      render json: { message: "oke" }
    else
      render json: { message: "Not found" }, status: :not_found
    end
  end

  private

  def record_params
    params.permit :name, :slug, :active, :parent_id
  end
end
