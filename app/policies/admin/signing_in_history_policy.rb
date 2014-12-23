class SigningInHistoryPolicy < ApplicationPolicy

  def index?
    current_user.role?('admin')
  end

end
