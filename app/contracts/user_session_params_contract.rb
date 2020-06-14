# frozen_string_literal: true

# UserSessionParamsContract
class UserSessionParamsContract < Dry::Validation::Contract
  params do
    required(:email).value(:string)
    required(:password).value(:string)
  end
end
