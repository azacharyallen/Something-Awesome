json.array!(@users) do |user|
  json.extract! user, :id, :username, :email, :session_token, :password_digest, :role
  json.url user_url(user, format: :json)
end
