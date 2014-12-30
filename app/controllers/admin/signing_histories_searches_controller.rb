class Admin::SigningHistoriesSearchesController < Admin::SigningInHistoriesController

  def new
    @signing_in_history_search = SigningInHistorySearch.new params[:search_params]
  end

end
