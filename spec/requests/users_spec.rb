require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'Signup a new user (POST /signup)' do
    let!(:role) { create(:student_role) }

    context 'when the parameters are valid' do
      let(:user_params) do
        { name: 'Felipe', email: 'felipe@mail.com', birthdate: '10/04/1999', password: '123465' }
      end

      before do
        post '/signup', params: user_params
      end

      it 'returns created status' do
        expect(response).to have_http_status(:created)
      end

      it 'sets the user name' do
        expect(JSON.parse(response.body)['name']).to eq(user_params[:name])
      end

      it 'sets the user email' do
        expect(JSON.parse(response.body)['email']).to eq(user_params[:email])
      end

      it 'sets the user birthdate' do
        expect(JSON.parse(response.body)['birthdate']).to eq(user_params[:birthdate])
      end

      it 'sets the user role as student' do
        expect(JSON.parse(response.body)['role']['name']).to eq('student')
      end
    end

    context 'when the name is empty' do
      it 'returns bad request status' do
        post '/signup',
             params: { name: '', email: 'felipe@mail.com', birthdate: '10/04/1999', password: '123456' }
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'when the email is empty' do
      it 'returns bad request status' do
        post '/signup',
             params: { name: 'Felipe', email: '', birthdate: '10/04/1999', password: '123456' }
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'when the password is empty' do
      it 'returns bad request status' do
        post '/signup',
             params: { name: 'Felipe', email: 'felipe@mail.com', birthdate: '10/04/1999', password: '' }
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'when the birthdate is empty' do
      it 'returns bad request status' do
        post '/signup',
             params: { name: 'Felipe', email: 'felipe@mail.com', birthdate: '', password: '123456' }
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'when the email is not unique' do
      let!(:student) { create(:student) }

      it 'returns bad request status' do
        post '/signup',
             params: { name: 'Felipe', email: student.email, birthdate: '10/04/1999', password: '123456' }
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'when the email is unique' do
      let!(:student) { create(:student) }

      it 'returns created status' do
        post '/signup',
             params: { name: 'Felipe', email: "a#{student.email}", birthdate: '10/04/1999', password: '123456' }
        expect(response).to have_http_status(:created)
      end
    end
  end

  describe 'Login an existing user (POST /login)' do
    let!(:user) { create(:student, password: '123456') }

    context 'when the login parameters are valid' do
      before do
        post '/login', params: { email: user.email, password: '123456' }
      end

      it 'returns ok status' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns the user name' do
        expect(JSON.parse(response.body)['name']).to eq(user.name)
      end

      it 'returns the user email' do
        expect(JSON.parse(response.body)['email']).to eq(user.email)
      end

      it 'returns the user birthdate' do
        expect(JSON.parse(response.body)['birthdate']).to eq(user.birthdate.strftime('%d/%m/%Y'))
      end

      it 'returns the user role as student' do
        expect(JSON.parse(response.body)['role']['name']).to eq(user.role.name)
      end

      it 'returns an authentication_token' do
        expect(JSON.parse(response.body)['authentication_token']).to eq(user.authentication_token)
      end
    end

    context 'when the email is invalid' do
      before do
        post '/login', params: { email: "#{user.email}a", password: '123456' }
      end

      it 'returns not found status' do
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'when the password is incorrect' do
      before do
        post '/login', params: { email: user.email, password: '654321' }
      end

      it 'returns unauthorized status' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'Logout a user (GET /logout)' do
    let!(:user) { create(:student) }

    context 'when the token and email headers are set' do
      before do
        get '/logout', headers: { 'X-User-Email': user.email, 'X-User-Token': user.authentication_token }
      end

      it 'returns ok status' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when the email header is invalid' do
      before do
        get '/logout', headers: { 'X-User-Email': "#{user.email}a", 'X-User-Token': user.authentication_token }
      end

      it 'returns unauthorized status' do
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when the token header is invalid' do
      before do
        get '/logout', headers: { 'X-User-Email': user.email, 'X-User-Token': "#{user.authentication_token}a" }
      end

      it 'returns unauthorized status' do
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when no header is passed (user not logged in)' do
      before do
        get '/logout'
      end

      it 'returns unauthorized status' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
