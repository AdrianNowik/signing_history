class DeactivateUserMailer < BaseMailer

  def send_deactivation_notice(receivers, user)
    @user_details = "#{user.name} [#{user.email}]"
    mail(to: receivers, subject: I18n.t('mailers.account_locked', user_details: @user_details))
  end

end
