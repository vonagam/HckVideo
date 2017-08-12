defmodule Phx.Coherence.Invitation do

  use Ecto.Schema

  import Ecto.Changeset


  schema "invitations" do

    field :name, :string

    field :email, :string

    field :token, :string

    timestamps()

  end


  def changeset( model, params \\ %{} ) do

    model

    |> cast( params, [ :name, :email, :token ] )

    |> validate_required( [ :name, :email ] )

    |> unique_constraint( :email )

    |> validate_format( :email, ~r/@/ )

  end

end
