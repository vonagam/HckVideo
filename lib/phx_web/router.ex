defmodule PhxWeb.Router do

  use PhxWeb, :router


  pipeline :browser do

    plug( :accepts, ~w( html json ) )

    plug( :fetch_session )

    plug( :fetch_flash )

    plug( :protect_from_forgery )

    plug( :put_secure_browser_headers )

  end

  pipeline :public do

    plug( Coherence.Authentication.Session )

  end

  pipeline :protected do

    plug( Coherence.Authentication.Session, protected: true )

  end


  scope "/" do

    pipe_through( [ :browser, :public ] )

    coherence_routes( :public )

  end

  scope "/" do

    pipe_through( [ :browser, :protected ] )

    coherence_routes( :protected )

  end

  scope "/", PhxWeb do

    pipe_through( [ :browser, :public ] )

    get( "/", PageController, :index )

  end

  if Phx.env?( :dev ) do

    scope "/dev" do

      pipe_through( [ :browser ] )

      forward( "/mailbox", Plug.Swoosh.MailboxPreview, [ base_path: "/dev/mailbox" ] )

    end

  end

  scope "/admin", ExAdmin do

    pipe_through( [ :browser ] )

    admin_routes()

  end

end
