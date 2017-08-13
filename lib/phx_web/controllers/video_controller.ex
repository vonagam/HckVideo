defmodule PhxWeb.VideoController do

  use PhxWeb, :controller

  alias Phx.Models


  # def subject( conn, %{ "type" => type, "id" => id } ) when type in [ "city", "group", "person", "type" ] do

  #   module = Models.get_module_by_singular( type )

  #   if String.match?( type, ~r/^\d+$/ ) do

  #     subject = Models.get_subject_by_id( module, String.to_integer( id ) )

  #     redirect( conn, to: video_path( conn, :subject, type, subject.slug ) )

  #   else

  #     subject = Models.get_subject_by_slug( module, id )

  #     videos = Models.list_subject_videos( subject )

  #     search = search_params( subject )

  #     render( conn, :index, subject: subject, videos: videos, search: search )

  #   end

  # end


  def search( conn, params ) do

    if subject = get_subject_from_search( params ) do

      videos = Models.list_subject_videos( subject )

      search = search_params( subject )

      render( conn, :index, subject: subject, videos: videos, search: search )

      # redirect( conn, to: video_path( conn, :subject, subject.__struct__.type(), subject.slug ) )

    else

      videos = Models.list_search_videos( params )

      search = search_params( params )

      render( conn, :index, subject: nil, videos: videos, search: search )

    end

  end

  defp get_subject_from_search( params ) do

    with(

      nil <- params[ "date" ],

      subjects <- params[ "subjects" ],

      true <- subjects != nil,

      1 <- Enum.count( subjects ),

      { key, ids } <- Enum.at( subjects, 0 ),

      [ id ] <- ids,

      module <- Models.get_module_by_plural( key ),

      subject <- Models.get_subject_by_id( module, id ),

      do: subject,

      else: ( _ -> nil ),

    )

  end

  defp search_params( subject = %_{} ) do

    %{

      "subjects" => %{ subject.__struct__.key() => [ subject.id ] }

    }

  end

  defp search_params( params ) do

    search = %{}

    search = if( params[ "date" ], do: Map.put( search, "date", params[ "date" ] ), else: search )

    search = if( params[ "subjects" ], do: Map.put( search, "subjects", params[ "subjects" ] ), else: search )

    search

  end

end
