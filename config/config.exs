use Mix.Config


config( :phoenix, :template_engines,

  slime: PhoenixSlime.Engine,

)

config( :logger, :console,

  format: "$time $metadata[$level] $message\n",

  metadata: [ :request_id ],

)

config( :phx,

  ecto_repos: [ Phx.Repo ],

)

config( :phx, PhxWeb.Endpoint,

  url: [ host: "localhost" ],

  secret_key_base: "eeSJJTu1RTAIqY0ZqpPiVaKF5Szc5E158IU/b7BzvWdHed7rOciJrJVCVES0Mzw5",

  render_errors: [ view: PhxWeb.ErrorView, accepts: ~w( html json ), layout: { PhxWeb.LayoutView, :app } ],

  pubsub: [ name: Phx.PubSub, adapter: Phoenix.PubSub.PG2 ],

)

config( :phx, :jsroutes,

  router: PhxWeb.Router,

  exclude: ~r{/admin},

  output_folder: "assets/source",

  output_file: "routes.js",

)

config( :coherence,

  user_schema: Phx.Coherence.User,

  repo: Phx.Repo,

  module: Phx,

  web_module: PhxWeb,

  router: PhxWeb.Router,

  messages_backend: PhxWeb.Coherence.Messages,

  logged_out_url: "/",

  email_from_name: "Your Name",

  email_from_email: "yourname@example.com",

  opts: [

    :registerable,

    :authenticatable,

    :rememberable,

    :trackable,

    :confirmable,

    :recoverable,

    :invitable,

    :lockable,

    :unlockable_with_token,

  ],

  user_token: true,

)

config( :ex_admin,

  repo: Phx.Repo,

  module: PhxWeb,    # MyProject.Web for phoenix >= 1.3.0-rc

  modules: [

    PhxWeb.ExAdmin.Dashboard,

  ],

)

config( :xain,

  after_callback: { Phoenix.HTML, :raw },

)


import_config( "#{ Mix.env }.exs" )
