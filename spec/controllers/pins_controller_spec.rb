require 'spec_helper'
RSpec.describe PinsController do

  describe "GET index" do

    it 'renders the index template' do
      get :index
      expect(response).to render_template("index")
    end

    it 'populates @pins with all pins' do
      get :index
      expect(assigns[:pins]).to eq(Pin.all)
    end

  end

  describe "GET new" do
    it 'responds with successfully' do
      get :new
      expect(response.success?).to be(true)
    end

    it 'renders the new view' do
      get :new
      expect(response).to render_template(:new)
    end

    it 'assigns an instance variable to a new pin' do
      get :new
      expect(assigns(:pin)).to be_a_new(Pin)
    end
  end

  describe "POST create" do
    before(:each) do
      @pin_hash = {
        title: "Rails Wizard",
        url: "http://railswizard.org",
        slug: "rails-wizard",
        text: "A fun and helpful Rails Resource"
      }
    end

    after(:each) do
      pin = Pin.find_by_slug("rails-wizard")
      if !pin.nil?
        pin.destroy
      end
    end

    it 'responds with a redirect' do
      post :create, pin: @pin_hash
      expect(response.redirect?).to be(true)
    end

    it 'creates a pin' do
      post :create, pin: @pin_hash
      expect(Pin.find_by_slug("rails-wizard").present?).to be(true)
    end

    it 'redirects to the show view' do
      post :create, pin: @pin_hash
      expect(response).to redirect_to(pin_url(assigns(:pin)))
    end

    it 'redisplays new form on error' do
      # The title is required in the Pin model, so we'll
      # delete the title from the @pin_hash in order
      # to test what happens with invalid parameters
      @pin_hash.delete(:title)
      post :create, pin: @pin_hash
      expect(response).to render_template(:new)
    end

    # it 'assigns the @errors instance variable on error' do
    #   # The title is required in the Pin model, so we'll
    #   # delete the title from the @pin_hash in order
    #   # to test what happens with invalid parameters
    #   @pin_hash.delete(:title)
    #   post :create, pin: @pin_hash
    #   expect(assigns[:errors].present?).to be(true)
    # end

  end

  describe "GET edit" do

    it "responds to GET" do
      get :edit, :id => "1"
      expect(response.body).to eq "edit called"
    end

    it "requires the :id parameter" do
      expect { get :edit }.to raise_error(ExpectedRoutingError)
    end

    # before(:each) do
    #   @pin = Pin.first
    # end
    # #get to pins/id/edit
    # #responds successfully
    # it 'responds with successfully following a GET to /edit' do
    #   get :edit, pin_id: @pin.id
    #   expect(response).to render_template("pins/1/edit")
    # end
    #renders the edit template
    #assigns an instance variable called @pin to the Pin with the appropriate id

  end

  describe "PUT update" do

  end

end
