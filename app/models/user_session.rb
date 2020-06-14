# frozen_string_literal: true

# UserSession
class UserSession < Sequel::Model
  plugin :uuid
  many_to_one :user
  # 
  # def before_validation
  #   self.uuid = SecureRandom.uuid
  #   super
  # end

  def validate
    super
    validates_presence :uuid, message: I18n.t(:blank, scope: 'model.errors.user_session.uuid')
  end
end
