class V1::ZenServiceController < ApplicationController

  def create_ticket()
    check_valid_params
    params = ticket_params
    begin
      ticket = ZendeskAPI::Ticket.new($client, subject: params["subject"],
                                      comment: { value: params["comment_value"] },
                                      requester: {name: current_user.profiles.first.fullname ,
                                                     email: current_user.email },
                                      priority: "urgent")
      ticket.save!
    rescue ZendeskAPI::Error::RecordInvalid => e
      render json: {
          error: e.to_s
      }
    end
  end

  def sign_into_zendesk(user = current_user)
    iat = Time.now.to_i
    jti = "#{iat}/#{SecureRandom.hex(18)}"
    payload = JWT.encode({
                             :iat   => iat, # Seconds since epoch, determine when this token is stale
                             :jti   => jti, # Unique token id, helps prevent replay attacks
                             :name  => user.profiles.first.fullname,
                             :email => user.email,
                         }, ZENDESK_SHARED_SECRET)
    zendesk_sso_url(payload)
  end

  def zendesk_sso_url(payload)
    url = "https://#{ZENDESK_SUBDOMAIN}.zendesk.com/access/jwt?jwt=#{payload}"
    render json: {url: url}
  end

  private

  def check_valid_params
    return render json: { error: 'Must have a comment' } unless params[:comment_value]
    return render json: { error: 'Must have a question title' } unless params[:subject]
  end

  def ticket_params
    params.permit(
        :subject,:comment_value, :requester,:name
    )
  end


end