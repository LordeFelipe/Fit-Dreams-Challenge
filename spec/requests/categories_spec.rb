# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Categories', type: :request do

  describe 'Get all categories (GET /category)' do
    let!(:categories) {FactoryBot.create_list(:category, 10)}

    it 'should return all categories' do 
      get '/category'
      expect(JSON.parse(response.body).size).to eq(10)
    end

    it 'should return ok status' do 
      get '/category'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'Get one category (GET /category/show/:id)' do

    context 'when the category exists' do 
      let!(:category) { FactoryBot.create(:category) }

      it 'should return ok status' do 
        get "/category/show/#{category.id}"
        expect(response).to have_http_status(:success)
      end

      it 'should have the same fields as the created category' do 
        get "/category/show/#{category.id}"
        expect(JSON.parse(response.body)['name']).to eq(category.name)
        expect(JSON.parse(response.body)['description']).to eq(category.description)
      end
    end

    context 'when the category does not exist' do 

      let!(:category) { FactoryBot.create(:category) }

      it 'should return bad request status' do 
        get "/category/show/#{category.id + 1}"
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe 'Create one category (POST /category/create)' do

    context 'when the parameters are valid' do 

      let(:category_params) do
        { name: 'Teste', description: 'Uma bela categoria.' }
      end

      it 'should return created status' do
        post '/category/create', params: category_params 
        expect(response).to have_http_status(:created)
      end

      it 'should have the same fields as the created category' do 
        post "/category/create", params: category_params
        expect(JSON.parse(response.body)['name']).to eq(category_params[:name])
        expect(JSON.parse(response.body)['description']).to eq(category_params[:description])
      end
    end

    context 'when the name is empty' do 

      it 'should return bad request status' do
        post '/category/create', params: {name: "", description: "Description"}
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'when the description is empty' do 

      it 'should return bad request status' do
        post '/category/create', params: {name: "Name", description: ""}
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe 'Update one category (PATCH /category/update/:id)' do

    context 'when the category exists' do 

      let!(:category) { FactoryBot.create(:category) }

      let(:category_params) do
        { name: 'Teste', description: 'Uma bela categoria.' }
      end

      it 'should return created status' do
        patch "/category/update/#{category.id}", params: category_params
        expect(response).to have_http_status(:ok)
      end

      it 'should have the same fields as the sent parameters' do 
        patch "/category/update/#{category.id}", params: category_params
        expect(JSON.parse(response.body)['name']).to eq(category_params[:name])
        expect(JSON.parse(response.body)['description']).to eq(category_params[:description])
      end
    end

    context 'when the category does not exist' do 
      
      let!(:category) { FactoryBot.create(:category) }

      let(:category_params) do
        { name: 'Teste', description: 'Uma bela categoria.' }
      end

      it 'should return bad request status' do
        patch "/category/update/#{category.id + 1}", params: category_params
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe 'Delete one category (DELETE /category/delete/:id)' do

    context 'when the category exists' do 

      let!(:category) { FactoryBot.create(:category) }

      it 'should return ok status' do
        delete "/category/delete/#{category.id}"
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when the category does not exist' do 
      
      let!(:category) { FactoryBot.create(:category) }

      it 'should return bad request status' do
        delete "/category/delete/#{category.id + 1}"
        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end
