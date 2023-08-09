# frozen_string_literal: true

class SuppliersController < ApplicationController
  attr_accessor :supplier

  helper_method :supplier

  def index; end

  def show
    @supplier = {
      name: permitted_params[:id]
    }
  end

  private

  def permitted_params
    params.permit(:id)
  end
end
