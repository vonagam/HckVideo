defmodule Phx do

  def env do

    Application.get_env( :phx, :env )

  end

  def env?( value ) do

     env() == value

  end

end
