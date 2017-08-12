defmodule Phx.Application do

  use Application


  def start( _type, _args ) do

    import Supervisor.Spec

    children = [

      supervisor( Phx.Repo, [] ),

      supervisor( PhxWeb.Endpoint, [] ),

      worker( Cachex, [ :layout_view ] ),

    ]

    Supervisor.start_link( children, strategy: :one_for_one, name: Phx.Supervisor )

  end

  def config_change( changed, _new, removed ) do

    PhxWeb.Endpoint.config_change( changed, removed )

    :ok

  end

end
