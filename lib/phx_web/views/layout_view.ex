defmodule PhxWeb.LayoutView do

  use PhxWeb, :view


  def render( "app.json", %{ view_module: view_module, view_template: view_template } = assigns ) do

    add_json_layout( assigns, render( view_module, view_template, assigns ) )

  end


  defp add_json_layout( %{ conn: conn } = assigns, view ) do

    error = assigns[ :kind ] == :error


    location = %{

      protocol: Atom.to_string( conn.scheme ) <> ":",

      hostname: conn.host,

      port: if( conn.port == 80 || conn.port == 443, do: "", else: Integer.to_string( conn.port ) ),

      pathname: conn.request_path,

      search: conn.query_string,

      query: conn.query_params,

    }

    location = Map.put( location, :host, location.hostname <> prepend_delimiter( ":", location.port ) )

    location = Map.put( location, :href, location.protocol <> "//" <> location.host <> location.pathname <> prepend_delimiter( "?", location.search ) )


    %{

      error: error,

      location: location,

      controller: unless( error, do: controller_module( conn ) |> module_to_string() ),

      action: unless( error, do: action_name( conn ) ),

      module: view_module( conn ) |> module_to_string(),

      template: view_template( conn ) |> String.replace_suffix( "." <> get_format( conn ), "" ),

      csrf: get_csrf_token(),

      flash: unless( error, do: get_flash( conn ) ),

      # locale

      # user

      view: view,

    }

  end

  defp prepend_delimiter( delimiter, value ) do

    if( value == "", do: "", else: delimiter <> value )

  end

  defp module_to_string( module ) do

    module |> Atom.to_string() |> String.replace_prefix( "Elixir.", "" )

  end


  defp assets_tags( bundle ) do

    if Phx.env?( :prod ) do

      fetch_cache "assets:" <> bundle, fn ->

        Application.app_dir( :phx, "priv/static/assets/manifest.json" )

        |> File.read!()

        |> Poison.decode!()

        |> Map.fetch!( bundle )

        |> Enum.map( fn( { type, path } ) ->

          path = cond do

            match = Regex.named_captures( ~r/^[^\.]+\.(?<hash>[^\.]+)\.[^\.]+$/u, path ) -> path <> "?vsn=" <> match[ "hash" ]

            true -> path

          end

          case type do

            "js" -> content_tag( :script, nil, src: path )

            "css" -> tag( :link, rel: "stylesheet", href: path )

          end

        end )

      end

    else

      content_tag( :script, nil, src: "http://localhost:8888/" <> bundle <> ".js" )

    end

  end

  defp favicon_tags do

    fetch_cache "favicons", fn ->

      json = case Phx.env() do

        :prod ->

          File.read!( Application.app_dir( :phx, "priv/static/assets/favicons.json" ) )

        _ ->

          ( %_{ status_code: 200 } = HTTPoison.get!( "http://localhost:8888/favicons.json" ) ).body

        #nd

      end


      html = json

      |> Poison.decode!()

      |> Map.fetch!( "html" )

      |> Enum.join( "\n" )


      { :safe, html }

    end

  end

  defp fetch_cache( key, fun ) do

    Cachex.get!( :layout_view, key, fallback: fn( _key ) -> fun.() end )

  end

end
