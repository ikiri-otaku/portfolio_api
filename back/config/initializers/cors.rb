# Read more: https://github.com/cyu/rack-cors

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    if Rails.env.development?
      origins 'http://localhost:8002', '192.168.208.3'
    else
      # TODO: 本番環境
      origins 'http://localhost:8000'
    end

    resource '*',
      headers: :any,
      methods: %i[get post put patch delete options head],
      expose: %w[access-token expiry token-type uid client]
  end
end
