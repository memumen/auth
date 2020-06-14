# frozen_string_literal: true

# UserSession
class UserSession < Sequel::Model
  many_to_one :user
end
