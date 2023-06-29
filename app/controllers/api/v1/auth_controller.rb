class Api::V1::AuthController < ApplicationController
  def login
    render json: { jwt: "abcd", user: "user" }
  end
end
