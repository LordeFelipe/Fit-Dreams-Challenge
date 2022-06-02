require 'rails_helper'

RSpec.describe 'Lessons', type: :request do
  describe 'Get all lessons (GET /lesson)' do
    let!(:lessons) { create_list(:lesson, 10) }

    before do
      get '/lesson'
    end

    it 'returns all lessons' do
      expect(JSON.parse(response.body).size).to eq(lessons.length)
    end

    it 'returns ok status' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'Get one lesson (GET /lesson/show/:id)' do
    context 'when the lesson exists' do
      let!(:lesson) { create(:lesson) }

      before do
        get "/lesson/show/#{lesson.id}"
      end

      it 'returns ok status' do
        expect(response).to have_http_status(:success)
      end

      it 'has the provided name' do
        expect(JSON.parse(response.body)['name']).to eq(lesson.name)
      end

      it 'has the provided description' do
        expect(JSON.parse(response.body)['description']).to eq(lesson.description)
      end

      it 'has the provided start_time' do
        expect(JSON.parse(response.body)['start_time']).to eq(lesson.start_time.to_s(:time))
      end

      it 'has the provided duration' do
        expect(JSON.parse(response.body)['duration']).to eq(lesson.duration.to_s(:time))
      end

      it 'has the provided category' do
        expect(JSON.parse(response.body)['category']['id']).to eq(lesson.category_id)
      end
    end

    context 'when the lesson does not exist' do
      let!(:lesson) { create(:lesson) }

      it 'returns bad request status' do
        get "/lesson/show/#{lesson.id + 1}"
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe 'Create one lesson (POST /lesson/create)' do
    let!(:category) { create(:category) }

    context 'when the parameters are valid' do
      let(:lesson_params) do
        { name: 'Teste', description: 'Teste.', duration: '01:00', start_time: '13:50', category_id: category.id }
      end

      before do
        post '/lesson/create', params: lesson_params
      end

      it 'returns created status' do
        expect(response).to have_http_status(:created)
      end

      it 'sets the lesson name' do
        expect(JSON.parse(response.body)['name']).to eq(lesson_params[:name])
      end

      it 'sets the lesson description' do
        expect(JSON.parse(response.body)['description']).to eq(lesson_params[:description])
      end

      it 'sets the lesson start_time' do
        expect(JSON.parse(response.body)['start_time']).to eq(lesson_params[:start_time])
      end

      it 'sets the lesson duration' do
        expect(JSON.parse(response.body)['duration']).to eq(lesson_params[:duration])
      end

      it 'sets the lesson category' do
        expect(JSON.parse(response.body)['category']['id']).to eq(lesson_params[:category_id])
      end
    end

    context 'when the name is empty' do
      it 'returns bad request status' do
        post '/lesson/create',
             params: { name: '', description: 'Teste.', duration: '01:00', start_time: '13:50',
                       category_id: category.id }
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'when the description is empty' do
      it 'returns bad request status' do
        post '/lesson/create',
             params: { name: 'Nome', description: '', duration: '01:00', start_time: '13:50', category_id: category.id }
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'when the duration is empty' do
      it 'returns bad request status' do
        post '/lesson/create',
             params: { name: 'Nome', description: 'Descrição', duration: '', start_time: '13:50',
                       category_id: category.id }
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'when the start_time is empty' do
      it 'returns bad request status' do
        post '/lesson/create',
             params: { name: 'Nome', description: 'Descrição', duration: '10:00', start_time: '',
                       category_id: category.id }
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'when the category is empty' do
      it 'returns bad request status' do
        post '/lesson/create',
             params: { name: 'Nome', description: 'Descrição', duration: '10:00', start_time: '22:00', category_id: '' }
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe 'Update one lesson (PATCH /lesson/update/:id)' do
    context 'when the lesson exists' do
      let!(:category) { create(:category) }
      let!(:lesson) { create(:lesson) }

      let(:lesson_params) do
        { name: 'Teste', description: 'Teste.', duration: '01:00', start_time: '13:50', category_id: category.id }
      end

      before do
        patch "/lesson/update/#{lesson.id}", params: lesson_params
      end

      it 'returns created status' do
        expect(response).to have_http_status(:ok)
      end

      it 'updates the lesson name' do
        expect(JSON.parse(response.body)['name']).to eq(lesson_params[:name])
      end

      it 'updates the lesson description' do
        expect(JSON.parse(response.body)['description']).to eq(lesson_params[:description])
      end

      it 'updates the lesson start_time' do
        expect(JSON.parse(response.body)['start_time']).to eq(lesson_params[:start_time])
      end

      it 'updates the lesson duration' do
        expect(JSON.parse(response.body)['duration']).to eq(lesson_params[:duration])
      end

      it 'updates the lesson category_id' do
        expect(JSON.parse(response.body)['category']['id']).to eq(lesson_params[:category_id])
      end
    end

    context 'when the lesson does not exist' do
      let!(:lesson) { create(:lesson) }

      let(:lesson_params) do
        { name: 'Teste', description: 'Uma bela categoria.' }
      end

      it 'returns bad request status' do
        patch "/lesson/update/#{lesson.id + 1}", params: lesson_params
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe 'Delete one lesson (DELETE /lesson/delete/:id)' do
    context 'when the lesson exists' do
      let!(:lesson) { create(:lesson) }

      it 'returns ok status' do
        delete "/lesson/delete/#{lesson.id}"
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when the lesson does not exist' do
      let!(:lesson) { create(:lesson) }

      it 'returns bad request status' do
        delete "/lesson/delete/#{lesson.id + 1}"
        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end
