# frozen_string_literal: true

module Auth
  # FetchUserService
  class FetchUserService
    prepend BasicService

    param :uuid

    attr_reader :user

    def call
      return forbidden if @uuid.blank? || session.blank?

      @user = session.user
    end

    private

    def forbidden
      fail!(I18n.t(:forbidden, scope: 'services.auth.fetch_user_service'))
    end

    def session
      @session ||= UserSession.find(uuid: @uuid)
    end
  end
end
