# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Phx.Repo.insert!(%Phx.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.


Phx.Repo.delete_all( Phx.Coherence.User )

Phx.Repo.delete_all( Phx.Models.City )

Phx.Repo.delete_all( Phx.Models.Group )

Phx.Repo.delete_all( Phx.Models.Person )

Phx.Repo.delete_all( Phx.Models.Type )

Phx.Repo.delete_all( Phx.Models.Video )


Phx.Coherence.User.changeset( %Phx.Coherence.User{}, %{

  name: "Test User",

  email: "testuser@example.com",

  password: "secret",

  password_confirmation: "secret"

} ) |> Phx.Repo.insert! |> Coherence.ControllerHelpers.confirm!


cities = Enum.map( [ "city one", "city two", "city three" ], fn( name ) ->

  %Phx.Models.City{} |> Phx.Models.City.changeset( %{ "name" => name } ) |> Phx.Repo.insert!

end )

groups = Enum.map( [ "group one", "group two", "group three" ], fn( name ) ->

  %Phx.Models.Group{} |> Phx.Models.Group.changeset( %{ "name" => name } ) |> Phx.Repo.insert!

end )

persons = Enum.map( [ "person one", "person two", "person three" ], fn( name ) ->

  %Phx.Models.Person{} |> Phx.Models.Person.changeset( %{ "name" => name } ) |> Phx.Repo.insert!

end )

types = Enum.map( [ "type one", "type two", "type three" ], fn( name ) ->

  %Phx.Models.Type{} |> Phx.Models.Type.changeset( %{ "name" => name } ) |> Phx.Repo.insert!

end )

videos = Enum.map( 1..20, fn( index ) ->

  %Phx.Models.Video{} |> Phx.Models.Video.changeset( %{

    "url" => "url #{ index }",

    "date" => DateTime.utc_now(),

    "subjects" => %{

      "cities" => cities |> Enum.take_random( 1 ) |> Enum.map( &( &1.id ) ),

      "groups" => groups |> Enum.take_random( Enum.random( 0..2 ) ) |> Enum.map( &( &1.id ) ),

      "persons" => persons |> Enum.take_random( Enum.random( 0..2 ) ) |> Enum.map( &( &1.id ) ),

      "types" => types |> Enum.take_random( Enum.random( 0..2 ) ) |> Enum.map( &( &1.id ) ),

    },

  } ) |> Phx.Repo.insert!

end )
