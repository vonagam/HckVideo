use Mix.Config


config( :logger,

  level: :warn

)

config( :phx,

  env: :test,

)

config( :phx, Phx.Repo,

  adapter: Ecto.Adapters.Postgres,

  username: "postgres",

  password: "postgres",

  database: "phx_test",

  hostname: "localhost",

  pool: Ecto.Adapters.SQL.Sandbox,

)

config( :phx, PhxWeb.Endpoint,

  http: [ port: 4001 ],

  server: false,

)

config( :coherence, PhxWeb.Coherence.Mailer,

  adapter: Swoosh.Adapters.Local,

)
