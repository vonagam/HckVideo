defmodule Phx.Repo do

  use Ecto.Repo, otp_app: :phx

  use Scrivener, page_size: 10


  def init( _, opts ) do

    { :ok, Keyword.put( opts, :url, System.get_env( "DATABASE_URL" ) ) }

  end

end
