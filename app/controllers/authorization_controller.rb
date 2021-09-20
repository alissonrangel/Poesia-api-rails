class AuthorizationController < ActionController::API

  def encode_token(payload)
    JWT.encode(payload, secret_key_base, 'HS256')
  end

  def secret_key_base
    Rails.application.credentials.secret_key_base
  end

  def header_token
    request.headers['Authorization']
  end

  def decoded_token
    JWT.decode(header_token, secret_key_base, true, {algorithm: 'HS256'})
  rescue
    nil
  end

  def current_user
    @current_user ||= User.find_by(id: decoded_token[0]["user_id"]) if decoded_token
  end

  def logged_in?
    render json: {error: "Usuário nao logado"} if current_user.blank?
  end
end
