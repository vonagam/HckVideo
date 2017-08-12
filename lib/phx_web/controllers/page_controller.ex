defmodule PhxWeb.PageController do

  use PhxWeb, :controller


  def index( conn, _params ) do

    render conn, :index

  end

end
