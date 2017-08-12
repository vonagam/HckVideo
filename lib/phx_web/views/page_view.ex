defmodule PhxWeb.PageView do

  use PhxWeb, :view


  defview( "index", _assigns ) do

    %{ x: 333 }

  end

end
