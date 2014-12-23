class CreateSigningInHistory
  require "browser"

  def initialize(login, request, status)
    @login = login
    @request = request
    @browser = Browser.new(:ua => @request.env['HTTP_USER_AGENT'])
    @status = status
  end

  def process
    SigningInHistory.create(login: @login, sign_succeed: @status, ip_address: @request.remote_ip, details: "#{@browser.platform}, #{@browser.name}",
                            user_id: user.try(:id))
  end

  def user
    User.find_by(email: @login)
  end


end
