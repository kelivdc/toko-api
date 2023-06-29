class Api::V1::UserController < ApplicationController
  def index
    start_param = params["_start"].to_i
    end_param = params["_end"].to_i
    sort_param = params["_sort"]
    order_param = params["_order"]

    per_page = end_param - start_param || 1
    page = (start_param / per_page) + 1

    q = User.ransack(name_or_email_cont: params[:q])
    result = q.result(distinct: true)

    collection = result.order("#{sort_param} #{order_param}").limit(per_page).offset(start_param)
    pagy = Pagy.new(count: result.count, page: page, items: per_page)
    response.headers["Access-Control-Allow-Origin"] = "*"
    response.headers["Access-Control-Expose-Headers"] = "X-Total-Count"
    response.headers["X-Total-Count"] = pagy.count
    render json: UserBlueprint.render(collection)
  end

  def show
    user = User.find(params[:id])
    render json: user
  end

  def update
    if user = User.find(params[:id])
      user.update(user_params)
      render json: user
    else
      render json: { message: "Not found" }, status: :not_found
    end
  end

  def create
    if user = User.create(user_params)
      render json: user
    else
      render json: user.errors, status: :bad_request
    end
  end

  def destroy
    if user = User.find(params[:id])
      user.delete
      render json: { message: "oke" }
    else
      render json: { message: "Not found" }, status: :not_found
    end
  end

  private

  def user_params
    params.permit :email, :name, :password
  end
end
