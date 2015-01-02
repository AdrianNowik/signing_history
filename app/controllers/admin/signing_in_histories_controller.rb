class Admin::SigningInHistoriesController < ApplicationController
  helper ApplicationHelper
  before_filter :require_login
  layout proc {|controller| controller.request.xhr? ? false : "administration" }

  def index
    @signing_in_histories =  SigningInHistorySearch.new(params[:signing_in_history_search]).search.paginate(page: params[:page] || 1, per_page: 15)
  end

end
