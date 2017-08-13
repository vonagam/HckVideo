defmodule Phx.Models do

  import Ecto.Query

  alias Phx.Repo

  alias Phx.Models.{ City, Group, Person, Type, Video }


  def get_module_by_singular( string ) do

    %{ "city" => City, "group" => Group, "person" => Person, "type" => Type }[ string ]

  end

  def get_module_by_plural( string ) do

    %{ "cities" => City, "groups" => Group, "persons" => Person, "types" => Type }[ string ]

  end


  def get_subject_by_id( module, id ) do

    module |> where( id: ^id ) |> Repo.one()

  end

  def get_subject_by_slug( module, slug ) do

    module |> where( slug: ^slug ) |> Repo.one()

  end

  def list_subject_videos( %{ __struct__: module, id: id } ) do

    Video

    |> where( visible: true )

    |> where( [ video ], fragment(

      "?->? @> ?",

      video.subjects,

      ^module.key(),

      ^id

    ) )

    |> Repo.all()

  end

  def list_search_videos( params = %{} ) do

    query = where( Video, visible: true )

    query = if date = params[ "date" ] do

      query = if( date[ "min" ], do: where( query, [ video ], video.date >= ^date[ "min" ] ), else: query )

      query = if( date[ "max" ], do: where( query, [ video ], video.date <= ^date[ "max" ] ), else: query )

      query

    else

      query

    end

    query = if subjects = params[ "subjects" ] do

      Enum.reduce subjects, query, fn( { key, ids }, query ) ->

        where( query, [ video ], fragment(

          "EXISTS(SELECT 1 FROM jsonb_array_elements_text(?->?) WHERE value = ANY(?))",

          video.subjects,

          ^key,

          ^ids

        ) )

      end

    else

      query

    end

    Repo.all( query )

  end


  def get_options do

    options = Enum.reduce( [ City, Group, Person, Type ], %{}, fn( module, options ) ->

      records = Repo.all( from( record in module, select: [ record.id, record.name ] ) )

      Map.put( options, module.key(), records )

    end )

    date_options = []

    date_options = date_options ++ [ Repo.one( from( video in Video, select: min( video.date ) ) ) ]

    date_options = date_options ++ [ Repo.one( from( video in Video, select: max( video.date ) ) ) ]

    options = Map.put( options, "date", date_options )

    options

  end


  def update_slug( %{ "name" => name } = params ) do

    Map.merge( params, %{ "slug" => Inflex.parameterize( name, "_" ) } )

  end

  def update_slug( params ), do: params

end


defimpl Poison.Encoder, for: Exfile.File do

  def encode( file, options ) do

    Poison.Encoder.BitString.encode( Exfile.Phoenix.Helpers.exfile_path( file ), options )

  end

end
