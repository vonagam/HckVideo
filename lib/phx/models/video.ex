defmodule Phx.Models.Video do

  use Ecto.Schema

  import Ecto.Changeset


  @derive { Poison.Encoder, only: [ :url, :title, :description, :date, :coordinates, :subjects, :views ] }

  schema "videos" do

    field( :url, :string )

    field( :title, :string )

    field( :description, :string )

    field( :date, :utc_datetime )

    field( :coordinates, { :array, :float } )

    field( :subjects, { :map, { :array, :integer } } )

    field( :views, :integer )

    field( :visible, :boolean, default: true )

  end


  def changeset( model, params \\ %{} ) do

    model

    |> cast( params, [ :url, :title, :description, :date, :coordinates, :subjects, :views, :visible ] )

    |> validate_required( [ :url, :date, :subjects, :visible ] )

  end

end
