require File.expand_path '../spec_helper.rb', __FILE__

describe 'Authentication' do

  it 'Allows homepage access' do
    get '/'
    expect(last_response).to be_ok
  end

  describe '/do/*' do

    let(:url_path) { '/do/test' }
    let(:bad_token) { 'bad' }
    let(:good_token) { ENV['TEST_TOKEN'] }

    before do
      Sinatra::Application.get('/do/test') { '' }
    end

    context 'No token' do

      it 'Denies access' do
        get url_path
        expect(last_response.status).to eq(401)
      end

    end

    context 'Bad token' do

      it 'Denies access' do
        get url_path, { :token => bad_token }
        expect(last_response.status).to eq(401)
      end

    end

    context 'Good token' do

      it 'Allows access' do
        get url_path, { :token => good_token }
        expect(last_response).to be_ok
      end

    end

  end

end
