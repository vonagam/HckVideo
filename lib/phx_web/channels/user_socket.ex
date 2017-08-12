defmodule PhxWeb.UserSocket do

  use Phoenix.Socket


  transport( :websocket, Phoenix.Transports.WebSocket )


  # def connect( %{ "token" => token }, socket ) do

  #   case Coherence.verify_user_token( socket, token, &assign/3 ) do

  #     { :error, _ } -> :error

  #     { :ok, socket } -> { :ok, socket }

  #   end

  # end

  def connect( _params, socket ) do

    { :ok, socket }

  end

  def id(_socket), do: nil

end
