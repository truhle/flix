describe UsersController do


  before do
    @user = User.create!(user_attributes)
  end

  context "when not signed in" do

    before do
      session[:user_id] = nil
    end

    it 'cannot access index' do
      get :index

      expect(response).to redirect_to(signin_url)
    end

    it 'cannot access show' do
      get :show, id: @user

      expect(response).to redirect_to(signin_url)
    end

    it 'cannot access edit' do
      get :edit, id: @user

      expect(response).to redirect_to(signin_url)
    end

    it 'cannot access update' do
      patch :update, id: @user

      expect(response).to redirect_to(signin_url)
    end

    it 'cannot access destroy' do
      delete :destroy, id: @user

      expect(response).to redirect_to(signin_url)
    end
  end

  context "when signed in as user other than the user being interacted with" do

    before do
      @other_user = User.create!(user_attributes(username: "other_user", email: "other@example.com"))
      session[:user_id] = @other_user.id
    end

    it 'cannot access another user' do
      patch :update, id: @user

      expect(response).to redirect_to(root_url)
    end

    it 'cannot access another user' do
      delete :destroy, id: @user

      expect(response).to redirect_to(root_url)
    end

    it 'cannot access another user' do
      get :edit, id: @user

      expect(response).to redirect_to(root_url)
    end




  end
end
