Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, 'bb390b0cb326a7a61e39', '1b767ae82d01506a284d47195895a335c8931be3'
end
