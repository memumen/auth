# frozen_string_literal: true

# User
class User < Sequel::Model
  NAME_FORMAT = %r{\A\w+\z}.freeze

  one_to_many :sessions
  plugin :association_dependencies, sessions: :delete
  plugin :secure_password, include_validations: false

  def validate
    super
    validates_presence :email, message: I18n.t(:blank, scope: 'model.errors.user.email')
    validates_presence :name, message: I18n.t(:blank, scope: 'model.errors.user.name')
    validates_presence :password, message: I18n.t(:blank, scope: 'model.errors.user.password')
    validates_format NAME_FORMAT, :name, message: I18n.t(:invalid, scope: 'model.errors.user.name')
  end
end
