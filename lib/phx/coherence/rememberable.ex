defmodule Phx.Coherence.Rememberable do

  use Ecto.Schema

  import Ecto.Changeset

  import Ecto.Query

  alias Coherence.Config


  schema "rememberables" do

    field :series_hash, :string

    field :token_hash, :string

    field :token_created_at, Timex.Ecto.DateTime

    belongs_to :user, Phx.Coherence.User

    timestamps()

  end

  use Coherence.Rememberable


  def changeset( model, params \\ %{} ) do

    model

    |> cast( params, [ :series_hash, :token_hash, :token_created_at, :user_id ] )

    |> validate_required( [ :series_hash, :token_hash, :token_created_at, :user_id ] )

  end

end
