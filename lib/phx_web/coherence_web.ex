defmodule PhxWeb.Coherence do

  defmacro __using__( which ) when is_atom( which ) do

    apply( __MODULE__, which, [] )

  end


  def view do

    quote do

      use PhxWeb, :view

      import PhxWeb.Coherence.ViewHelpers

    end

  end

  def controller do

    quote do

      use PhxWeb, :controller

      use Coherence.Config

      use Timex

      import Ecto

      import Ecto.Query

      import Coherence.ControllerHelpers

      alias Coherence.Config

      alias Coherence.ControllerHelpers, as: Helpers

      require Redirects

    end

  end

end
