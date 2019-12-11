Rails.application.config.middleware.use OmniAuth::Builder do
    provider :github, client_id:"7774a50f60168d027b12", client_secret:"72c4975e0c8966846024a9d30ae001338b1550c0", scope: "user,repo,gist"
  end