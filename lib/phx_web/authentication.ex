defmodule PhxWeb.Authentication do

  def current_user(conn) do

    Coherence.current_user(conn)

  end

end
