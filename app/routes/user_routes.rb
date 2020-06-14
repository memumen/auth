# frozen_string_literal: true

# UserRoutes
class UserRoutes < Application
  post '/signup' do
    user_params = validate_with!(UserParamsContract)
    result = Users::CreateService.call(
      user_params[:name], user_params[:email], user_params[:password]
    )

    if result.success?
      status 201
    else
      status 422
      error_response result.user
    end
  end

  post '/login' do
    json({ login: true })
  end
end
