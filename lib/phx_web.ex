defmodule PhxWeb do

  defmacro __using__( which ) when is_atom( which ) do

    apply( __MODULE__, which, [] )

  end


  def controller do

    quote do

      use Phoenix.Controller, namespace: PhxWeb

      import Plug.Conn

      import PhxWeb.Router.Helpers

      import PhxWeb.Gettext

      import PhxWeb.Authentication

    end

  end

  def view do

    quote do

      use Phoenix.View, root: "lib/phx_web/templates", namespace: PhxWeb

      use Phoenix.HTML

      import Phoenix.Controller, except: [ render: 2, render: 3, render: 4 ]

      import PhxWeb.Router.Helpers

      import PhxWeb.ErrorHelpers

      import PhxWeb.ReactHelpers

      import PhxWeb.Gettext

    end

  end

  def endpoint do

    quote do

      use Phoenix.Endpoint, otp_app: :phx

      import Phoenix.Controller

    end

  end

  def router do

    quote do

      use Phoenix.Router

      use Coherence.Router

      use ExAdmin.Router

      import Plug.Conn

      import Phoenix.Controller

      import PhxWeb.Authentication

    end

  end

  def channel do

    quote do

      use Phoenix.Channel

      import PhxWeb.Gettext

    end

  end

end
