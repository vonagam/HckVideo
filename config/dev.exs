use Mix.Config


config( :logger, :console,

  format: "[$level] $message\n",

)

config( :phoenix,

  stacktrace_depth: 20,

)

config( :phx,

  env: :dev,

)

config( :phx, Phx.Repo,

  adapter: Ecto.Adapters.Postgres,

  username: "postgres",

  password: "postgres",

  database: "phx_dev",

  hostname: "localhost",

  pool_size: 10,

)

config( :phx, PhxWeb.Endpoint,

  http: [ port: 4000 ],

  debug_errors: true,

  code_reloader: true,

  reloadable_compilers: [ :gettext, :phoenix, :elixir, :jsroutes ],

  check_origin: false,

  watchers: [

    # yarn: [ "run", "start", cd: Path.expand( "../assets", __DIR__ ) ],

  ],

  live_reload: [

    patterns: [

      ~r{priv/gettext/.*(po)$},

      ~r{lib/phx_web/views/.*(ex)$},

      ~r{lib/phx_web/templates/.*(eex|slime)$},

    ],

  ],

)

config( :coherence, PhxWeb.Coherence.Mailer,

  adapter: Swoosh.Adapters.Local,

)
