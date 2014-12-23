class SigningsController < SessionsController

  def create
    begin
      super
    ensure
      save_signing_history
    end
  end

  def save_signing_history
    CreateSigningInHistory.new(params[:user][:email], request, user_signed_in?).process
  end
end
