require 'rails_helper'

RSpec.describe ShortUrlsController, type: :controller do

  describe "POST #create" do
  
    context "with valid attributes" do

      it "create new short_url" do
        post :create, { params: { short_url: attributes_for(:short_url) } }
        
        expect(ShortUrl.count).to eq(1)
        expect(response).to have_http_status(302)
      end
    end
  end

  describe "Get #index" do
  
    context "fetch all short url records" do
      
      let!(:short_url) { create(:short_url) }

      it "fetches all records" do
        get :index

        expect(ShortUrl.count).to eq(1)
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "Get #new" do

    it "fetch build a new record" do
      get :new

      expect(response).to have_http_status(200)
      expect(assigns(:url).class).to eq ShortUrl
    end
  end

  describe "Get #show" do
    let!(:short_url) { create(:short_url) }

    it "fetch a record by id" do
      get :show, params: { id: short_url.slug }

      expect(response).to have_http_status(200)
      expect(assigns(:url)).to eq short_url
    end
  end

  describe "Get #redirect" do
    let!(:short_url) { create(:short_url) }

    it "fetch a record by slug" do
      get :redirect, params: { short_url: short_url.slug }

      expect(response).to have_http_status(302)
      expect(assigns(:url)).to eq short_url
    end
  end
end