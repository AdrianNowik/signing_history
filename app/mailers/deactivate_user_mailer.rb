class DeactivateUserMailer < BaseMailer

  def send_deactivation_notice(receiver, user)
    @user_details = "#{user.name} [#{user.email}]"
    mail(bcc: receiver, subject: I18n.t('mailers.account_locked', user_details: @user_details))
  end

end
