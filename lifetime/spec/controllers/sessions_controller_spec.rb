require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  describe 'create method' do
    before(:each) do
      @new_user = User.create(:firstname => "moo", :lastname => "woof", :image => "wwwwghuorhfwouh", :age => 13, :weight_kgs => 400, :height_meters => 3.65, :gender => true)
      @new_auth = Authorization.create(:provider => 'jawbone', :uid => '378349782589439804',:access_token => "wehifehefhkw", :refresh_token => "gehefuihawduwda", user_id: @new_user.id)
      @new_activity = Activity.create(steps: steps)
      @new_day = Day.create(user_id: @new_user.id, date: day_data[0], activity_id: @new_activity.id)
    end

    after(:each) do
      @new_user.destroy
      @new_auth.destroy
      @new_activity.destroy
      @new_day.destroy
    end
  describe "get_trends method" do

    it "assigns the @trends_response instance varibale" do
      expect(assigns :trends_response).to be_a_kind_of(HTTParty::Response)
    end

    it "assigns the @weight instance variable" do
      expect(assigns :weight).to be_kind_of(Integer)
    end

    it "assigns the @age instance variable" do
      expect(assigns :age).to be_kind_of(Integer)
    end

    it "assigns the @height instance variable" do
      expect(assigns :height).to be_kind_of(Fixnum)
    end

    it "assigns the @gender instance variable" do
      expect(assigns :gender).to_not be_nil
    end
  end


    it "assigns auth_token variable" do
      expect(auth_hash).to be_a_kind_of(OmniAuth::AuthHash)
    end

    it 'assigns the correct session id' do
      expect(session[:id]).to eq(@new_user.id)
    end


  end

end
