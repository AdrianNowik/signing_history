class CreateSigningInHistory
  require "browser"
  class DeactivatedError < StandardError; end
  class WrongLoginParamsError < StandardError; end

  def initialize(login, request, status)
    @login = login
    @status = status
    @request = request
    @browser = Browser.new(:ua => @request.env['HTTP_USER_AGENT'])
  end

  def process
    SigningInHistory.create(login: @login, sign_succeed: @status, ip_address: @request.remote_ip, details: "#{@browser.platform}, #{@browser.name}",
                            user_id: user.try(:id))
    raise WrongLoginParamsError.new if user.blank?
    raise DeactivatedError.new if user.deactivated
    if !@status && exceeded_failed_login_attempts?
      DeactivateUser.new(user).process
      raise DeactivatedError.new
    end
    user_failed_attempts
  end

  def user
    User.find_by(email: @login)
  end

  def user_failed_attempts
    user.signing_in_histories.failed.active.count
  end

  def exceeded_failed_login_attempts?
    user_failed_attempts > SigningHistory.max_failed_login_attempts
  end

end
