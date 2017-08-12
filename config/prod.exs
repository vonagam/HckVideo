use Mix.Config


config( :logger,

  level: :info,

)

config( :phx,

  env: :prod,

)

config( :phx, PhxWeb.Endpoint,

  load_from_system_env: true,

)


import_config( "prod.secret.exs" )
