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


Phx.Repo.delete_all( Phx.Coherence.User)


Phx.Coherence.User.changeset( %Phx.Coherence.User{}, %{

  name: "Test User",

  email: "testuser@example.com",

  password: "secret",

  password_confirmation: "secret"

} ) |> Phx.Repo.insert! |> Coherence.ControllerHelpers.confirm!
