Phx.Repo.delete_all( Phx.Models.City )

cities = File.stream!( "priv/repo/Cities.csv" ) |> CSV.decode! |> Enum.map( fn( [ name, lat, long ] ) ->

  %Phx.Models.City{} |> Phx.Models.City.changeset( %{

    "name" => name,

    "coordinates" => [ lat, long ],

  } ) |> Phx.Repo.insert!

end )


Phx.Repo.delete_all( Phx.Models.Group )

groups = File.stream!( "priv/repo/Groups.csv" ) |> CSV.decode! |> Enum.map( fn( [ name, image ] ) ->

  %HTTPoison.Response{ body: body } = HTTPoison.get!( image )

  File.write!( "/tmp/image.png", body )

  %Phx.Models.Group{} |> Phx.Models.Group.changeset( %{

    "name" => name,

    "image" => %Plug.Upload{ path: "/tmp/image.png", content_type: "image/png", filename: "image.png" },

  } ) |> Phx.Repo.insert!

end )


Phx.Repo.delete_all( Phx.Models.Person )

persons = File.stream!( "priv/repo/Persons.csv" ) |> CSV.decode! |> Enum.map( fn( [ name, image ] ) ->

  %HTTPoison.Response{ body: body } = HTTPoison.get!( image )

  File.write!( "/tmp/image.png", body )

  %Phx.Models.Person{} |> Phx.Models.Person.changeset( %{

    "name" => name,

    "image" => %Plug.Upload{ path: "/tmp/image.png", content_type: "image/png", filename: "image.png" },

  } ) |> Phx.Repo.insert!

end )


Phx.Repo.delete_all( Phx.Models.Type )

types = File.stream!( "priv/repo/Types.csv" ) |> CSV.decode! |> Enum.map( fn( [ name, image ] ) ->

  %HTTPoison.Response{ body: body } = HTTPoison.get!( image )

  File.write!( "/tmp/image.png", body )

  %Phx.Models.Type{} |> Phx.Models.Type.changeset( %{

    "name" => name,

    "image" => %Plug.Upload{ path: "/tmp/image.png", content_type: "image/png", filename: "image.png" },

  } ) |> Phx.Repo.insert!

end )


Phx.Repo.delete_all( Phx.Models.Video )

File.stream!( "priv/repo/Video.csv" ) |> CSV.decode! |> Enum.map( fn( [ id ] ) ->

  two_cities = cities |> Enum.take_random( 2 )

  first_city = List.first( two_cities )

  second_city = List.last( two_cities )

  weight = Enum.random( 1..5 ) * 0.01

  coordinates = [

    List.first( first_city.coordinates ) * ( 1 - weight ) + List.first( second_city.coordinates ) * weight,

    List.last( first_city.coordinates ) * ( 1 - weight ) + List.last( second_city.coordinates ) * weight,

  ]


  %Phx.Models.Video{} |> Phx.Models.Video.changeset( %{

    "url" => id,

    "date" => DateTime.utc_now(),

    "coordinates" => coordinates,

    "subjects" => %{

      "cities" => [ first_city.id ],

      "groups" => groups |> Enum.take_random( Enum.random( 0..2 ) ) |> Enum.map( &( &1.id ) ),

      "persons" => persons |> Enum.take_random( Enum.random( 0..2 ) ) |> Enum.map( &( &1.id ) ),

      "types" => types |> Enum.take_random( Enum.random( 0..2 ) ) |> Enum.map( &( &1.id ) ),

    },

  } ) |> Phx.Repo.insert!

end )
