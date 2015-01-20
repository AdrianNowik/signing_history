class SigningInHistorySearch

  include ActiveModel::Model
  def initialize(args={})
    args.present? && args.each do |k,v|
      instance_variable_set("@#{k}", v) unless v.nil?
    end
  end

  attr_accessor :login, :sign_succeed, :date_from, :date_to
  EQUAL_ATTRS = [:login, :sign_succeed]


  def search
    signing_histories = SigningInHistory.all.order(:created_at)
    if @sign_succeed.present?
      signing_histories = signing_histories.where(sign_succeed: @sign_succeed)
    end
    if @login.present?
      signing_histories = signing_histories.where("signing_in_histories.login ilike '%#{@login}%'")
    end
    if @date_from.present? && @date_to.present?
      signing_histories = signing_histories.where('created_at > ? AND created_at < ?', @date_from, @date_to)
    elsif @date_from.present? && !@date_to.present?
      signing_histories = signing_histories.where('created_at > ?', @date_from)
    elsif !@date_from.present? && @date_to.present?
      signing_histories = signing_histories.where('created_at < ?', @date_to)
    end
    signing_histories
  end

end
