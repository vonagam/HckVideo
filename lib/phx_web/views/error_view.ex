defmodule PhxWeb.ErrorView do

  use PhxWeb, :view


  defview( "404", _assigns ) do

    %{ error: "Page not found" }

  end

  defview( "500", _assigns ) do

    %{ error: "Internal server error" }

  end


  def template_not_found( _template, assigns ) do

    render "500." <> get_format( assigns.conn ), assigns

  end

end
