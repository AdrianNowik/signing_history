class CreateSigningInHistory
  require "browser"
  class DeactivatedError < StandardError; end
  class WrongLoginParamsError < StandardError; end

  def initialize(login, password, request)
    @login = login
    @password = password
    @request = request
    @browser = Browser.new(:ua => @request.env['HTTP_USER_AGENT'])
  end

  def process
    SigningInHistory.create(login: @login, sign_succeed: sign_params_correct?, ip_address: @request.remote_ip, details: "#{@browser.platform}, #{@browser.name}",
                            user_id: user.try(:id))
    raise WrongLoginParamsError.new if user.blank?
    if exceeded_failed_login_attempts?
      deactivate_user
      send_deactivation_notice
      raise DeactivatedError.new
    end
    {status: sign_params_correct?, failed_attempts: user_failed_attempts}
  end

  def user
    User.find_by(email: @login)
  end

  def sign_params_correct?
    user.present? && user.valid_password?(@password)
  end

  def deactivate_user
    user.update(active: false)
  end

  def user_failed_attempts
    user.signing_in_histories.failed.active.count
  end

  def exceeded_failed_login_attempts?
    user_failed_attempts > SigningHistory.max_failed_login_attempts
  end

  def send_deactivation_notice
    User.joins(:roles).where("roles.name = 'admin'").each do |receiver|
      DeactivateUserMailer.delay(run_at: 1.minute.from_now).send_deactivation_notice(receiver.email, user)
    end
  end

end
