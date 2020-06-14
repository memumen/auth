# frozen_string_literal: true

# UserRoutes
class UserRoutes < Application
  helpers Auth

  post '/signup' do
    user_params = validate_with!(UserParamsContract)
    result = Users::CreateService.call(*user_params.to_h.values)

    if result.success?
      status 201
    else
      status 422
      error_response result.user
    end
  end

  post '/login' do
    session_params = validate_with!(UserSessionParamsContract)
    result = UserSessions::CreateService.call(*session_params.to_h.values)

    if result.success?
      token = JwtEncoder.encode(uuid: result.session.uuid)
      meta = { token: token }

      status 201
      json meta: meta
    else
      status 401
      error_response result.session || result.errors
    end
  end

  post '/' do
    result = Auth::FetchUserService.call(extracted_token['uuid'])

    if result.success?
      meta = { user_id: result.user.id }

      status 200
      json meta: meta
    else
      status 403
      error_response(result.errors)
    end
  end
end
