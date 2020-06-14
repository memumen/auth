# frozen_string_literal: true

RSpec.describe UserRoutes, type: :routes do
  describe 'POST /signup' do
    context 'missing parameters' do
      it 'returns an error' do
        post '/signup', { name: 'bob', email: 'bob@example.com', password: '' }

        expect(last_response.status).to eq(422)
      end
    end

    context 'invalid parameters' do
      it 'returns an error' do
        post '/signup', { name: 'b.o.b', email: 'bob@example.com', password: 'givemeatoken' }

        expect(last_response.status).to eq(422)
        expect(response_body['errors']).to include(
          {
            'detail' => 'Укажите имя, используя буквы, цифры или символ подчёркивания',
            'source' => {
              'pointer' => '/data/attributes/name'
            }
          }
        )
      end
    end

    context 'valid parameters' do
      it 'returns created status' do
        post '/signup', { name: 'bob', email: 'bob@example.com', password: 'givemeatoken' }

        expect(last_response.status).to eq(201)
      end
    end
  end

  describe 'POST /login' do
    context 'missing parameters' do
      it 'returns an error' do
        post '/login', { email: 'bob@example.com', password: '' }

        expect(last_response.status).to eq(401)
      end
    end

    context 'invalid parameters' do
      it 'returns an error' do
        post '/login', { email: 'bob@example.com', password: 'invalid' }

        expect(last_response.status).to eq(401)
        expect(response_body['errors']).to include('detail' => 'Сессия не может быть создана')
      end
    end

    context 'valid parameters' do
      let(:token) { 'jwt_token' }

      before do
        create(:user, email: 'bob@example.com', password: 'givemeatoken')

        allow(JWT).to receive(:encode).and_return(token)
      end

      it 'returns created status' do
        post '/login', { email: 'bob@example.com', password: 'givemeatoken' }

        expect(last_response.status).to eq(201)
        expect(response_body['meta']).to eq('token' => token)
      end
    end
  end
end
