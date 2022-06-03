# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Categories', type: :request do
  let!(:admin) { create(:admin) }
  let(:admin_headers) do
    { 'X-User-Email': admin.email, 'X-User-Token': admin.authentication_token }
  end

  describe 'Get all categories (GET /category)' do
    let!(:categories) { create_list(:category, 10) }

    before do
      get '/category'
    end

    it 'returns all categories' do
      expect(JSON.parse(response.body).size).to eq(categories.length)
    end

    it 'returns ok status' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'Get one category (GET /category/show/:id)' do
    context 'when the category exists' do
      let!(:category) { create(:category) }

      before do
        get "/category/show/#{category.id}"
      end

      it 'returns ok status' do
        expect(response).to have_http_status(:success)
      end

      it 'has the provided name' do
        expect(JSON.parse(response.body)['name']).to eq(category.name)
      end

      it 'has the provided description' do
        expect(JSON.parse(response.body)['description']).to eq(category.description)
      end
    end

    context 'when the category does not exist' do
      let!(:category) { create(:category) }

      it 'returns bad request status' do
        get "/category/show/#{category.id + 1}"
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe 'Create one category (POST /category/create)' do
    context 'when the parameters are valid and the admin is logged in' do
      let(:category_params) do
        { name: 'Teste', description: 'Uma bela categoria.' }
      end

      before do
        post '/category/create', params: category_params, headers: admin_headers
      end

      it 'returns created status' do
        expect(response).to have_http_status(:created)
      end

      it 'sets the category name' do
        expect(JSON.parse(response.body)['name']).to eq(category_params[:name])
      end

      it 'sets the category description' do
        expect(JSON.parse(response.body)['description']).to eq(category_params[:description])
      end
    end

    context 'when an admin is not logged in' do
      let(:category_params) do
        { name: 'Teste', description: 'Uma bela categoria.' }
      end

      it 'returns status forbidden' do
        post '/category/create', params: category_params
        expect(response).to have_http_status(:forbidden)
      end
    end

    context 'when the name is empty' do
      it 'returns bad request status' do
        post '/category/create', params: { name: '', description: 'Description' }, headers: admin_headers
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'when the description is empty' do
      it 'returns bad request status' do
        post '/category/create', params: { name: 'Name', description: '' }, headers: admin_headers
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe 'Update one category (PATCH /category/update/:id)' do
    context 'when the category exists and the admin is logged in' do
      let!(:category) { create(:category) }

      let(:category_params) do
        { name: 'Teste', description: 'Uma bela categoria.' }
      end

      before do
        patch "/category/update/#{category.id}", params: category_params, headers: admin_headers
      end

      it 'returns created status' do
        expect(response).to have_http_status(:ok)
      end

      it 'updates the category name' do
        expect(JSON.parse(response.body)['name']).to eq(category_params[:name])
      end

      it 'updates the category description' do
        expect(JSON.parse(response.body)['description']).to eq(category_params[:description])
      end
    end

    context 'when an admin is not logged in' do
      let!(:category) { create(:category) }
      let(:category_params) do
        { name: 'Teste', description: 'Uma bela categoria.' }
      end

      it 'returns status forbidden' do
        patch "/category/update/#{category.id}", params: category_params
        expect(response).to have_http_status(:forbidden)
      end
    end

    context 'when the category does not exist' do
      let!(:category) { create(:category) }

      let(:category_params) do
        { name: 'Teste', description: 'Uma bela categoria.' }
      end

      it 'returns bad request status' do
        patch "/category/update/#{category.id + 1}", params: category_params, headers: admin_headers
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe 'Delete one category (DELETE /category/delete/:id)' do
    let!(:category) { create(:category) }

    context 'when the category exists and the admin is logged in' do
      it 'returns ok status' do
        delete "/category/delete/#{category.id}", headers: admin_headers
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when the category does not exist' do
      it 'returns bad request status' do
        delete "/category/delete/#{category.id + 1}", headers: admin_headers
        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end
