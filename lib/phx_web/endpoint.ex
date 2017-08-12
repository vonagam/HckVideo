defmodule PhxWeb.Endpoint do

  use PhxWeb, :endpoint


  socket( "/socket", PhxWeb.UserSocket )

  if Phx.env?( :prod )  do

    plug( Plug.Static, at: "/", from: :phx, only: ~w(

      assets

      robots.txt

      css fonts images js

    ), gzip: true )

  else

    plug( Plug.Static, at: "/", from: :phx, only: ~w(

      robots.txt

      css fonts images js

    ) )

  end

  plug( TrailingFormatPlug )

  if code_reloading? do

    socket( "/phoenix/live_reload/socket", Phoenix.LiveReloader.Socket )

    plug( Phoenix.LiveReloader )

    plug( Phoenix.CodeReloader )

  end

  plug( Plug.RequestId )

  plug( Plug.Logger )

  plug( Plug.Parsers, parsers: [ :urlencoded, :multipart, :json ],  pass: [ "*/*" ], json_decoder: Poison )

  plug( Plug.MethodOverride )

  plug( Plug.Head )

  plug( Plug.Session, store: :cookie, key: "_phx_key", signing_salt: "ChXyaTBh" )

  plug( :put_layout_formats, ~w( html json ) )

  plug( PhxWeb.Router )


  def init( _key, config ) do

    if config[ :load_from_system_env ] do

      port = System.get_env( "PORT" ) || raise "expected the PORT environment variable to be set"

      { :ok, Keyword.put( config, :http, [ :inet6, port: port ] ) }

    else

      { :ok, config }

    end

  end

end
