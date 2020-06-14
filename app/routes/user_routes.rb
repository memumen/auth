# frozen_string_literal: true

# UserRoutes
class UserRoutes < Application
  post '/signup' do
    json({ signup: true })
  end

  post '/login' do
    json({ login: true })
  end
end
