module ControllerMacros
  def login_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      admin = FactoryBot.create(:user)
      sign_in :user, user # sign_in(scope, resource)
    end
  end
end