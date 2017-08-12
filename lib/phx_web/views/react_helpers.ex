defmodule PhxWeb.ReactHelpers do

  defmacro defview( name, assigns, do: expression ) do

    quote do

      def render( unquote( name <> ".json" ), unquote( assigns ) ), do: unquote( expression )

      def render( unquote( name <> ".html" ), assigns ) do

        json = render( unquote( name <> ".json" ), assigns )

        PhxWeb.LayoutView.render( "react.html", Map.put( assigns, :json, json ) )

      end

    end

  end

end
