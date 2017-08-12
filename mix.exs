defmodule Phx.Mixfile do

  use Mix.Project


  def project do

    [

      app: :phx,

      version: "0.0.1",

      elixir: "~> 1.5",

      elixirc_paths: if( Mix.env == :test, do: [ "lib", "test/support" ], else: [ "lib" ] ),

      compilers: [ :phoenix, :gettext ] ++ Mix.compilers ++ [ :jsroutes ],

      start_permanent: Mix.env == :prod,

      aliases: [

        "ecto.setup": [ "ecto.create", "ecto.migrate", "run priv/repo/seeds.exs" ],

        "ecto.reset": [ "ecto.drop", "ecto.setup" ],

        "test": [ "ecto.create --quiet", "ecto.migrate", "test" ],

      ],

      deps: [

        { :phoenix, "~> 1.3.0" },

        { :phoenix_pubsub, "~> 1.0" },

        { :phoenix_ecto, "~> 3.2" },

        { :postgrex, ">= 0.0.0" },

        { :phoenix_html, "~> 2.10" },

        { :phoenix_live_reload, "~> 1.0", only: :dev },

        { :gettext, "~> 0.11" },

        { :cowboy, "~> 1.0" },

        { :canary, github: "cpjk/canary" },

        { :coherence, "~> 0.4" },

        { :cachex, "~> 2.1" },

        { :httpoison, "~> 0.12" },

        { :trailing_format_plug, github: "vonagam/trailing_format_plug" },

        { :phoenix_slime, "~> 0.8.0" },

        { :phoenix_jsroutes, github: "vonagam/phoenix-jsroutes" },

        { :ex_admin, github: "smpallen99/ex_admin" },

      ],

    ]

  end

  def application do

    [

      mod: { Phx.Application, [] },

      extra_applications: [ :logger, :runtime_tools ],

    ]

  end

end
