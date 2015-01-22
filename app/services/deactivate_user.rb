class DeactivateUser

  def initialize(user)
    @user = user
  end

  def process
    deactivate_user
    send_deactivation_notice
  end

  def deactivate_user
    @user.update!(deactivated: true)
  end

  def admin_emails
    User.joins(:roles).where("roles.name = 'admin'").pluck(:email).join(',')
  end

  def send_deactivation_notice
    DeactivateUserMailer.delay(run_at: 1.minute.from_now).send_deactivation_notice(admin_emails, @user)
  end
end
