class Users::ConfirmationsController < Devise::ConfirmationsController
  def show
    super do |resource|
      if successfully_sent?(resource)
        access_token = Doorkeeper::AccessToken.create!({
                                                    :resource_owner_id  => resource.id,
                                                    :expires_in         => Doorkeeper.configuration.access_token_expires_in,
                                                    :use_refresh_token  => Doorkeeper.configuration.refresh_token_enabled?
                                                })
        auth_object = {
          access_token: access_token.token,
          token_type: "Bearer",
          expires_in: access_token.expires_in,
          created_at: access_token.created_at,
          refresh_token: access_token.refresh_token
        }
       return render json: auth_object.to_json, status: 200
      else
       return render json: { error: resource.errors.messages }.to_json
      end
    end
  end

  end
