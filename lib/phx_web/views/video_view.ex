defmodule PhxWeb.VideoView do

  use PhxWeb, :view


  defview( "index", %{ subject: subject, videos: videos, search: search } ) do

    %{ subject: subject, videos: videos, search: search }

  end

end
