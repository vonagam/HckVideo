defmodule Phx.Models.Type do

  use Ecto.Schema

  import Ecto.Changeset

  import Exfile.Ecto.{ ValidateFileSize, ValidateContentType }


  @derive { Poison.Encoder, only: [ :slug, :name, :description, :image ] }

  schema "types" do

    field( :slug, :string )

    field( :name, :string )

    field( :description, :string )

    field( :image, Exfile.Ecto.File )

  end


  def type, do: "type"

  def key, do: "types"

  def changeset( model, params \\ %{} ) do

    params = Phx.Models.update_slug( params )


    model

    |> cast( params, [ :slug, :name, :description, :image ] )

    |> validate_required( [ :slug, :name ] )

    |> do_files_changeset()

  end

  defp do_files_changeset( changeset ) do

    if get_change( changeset, :image ) do

      changeset

      |> validate_content_type( :image, :image )

      |> validate_file_size( :image, 10_000_000 )

      |> Exfile.Ecto.prepare_uploads( [ :image ] )

    else

      changeset

    end

  end

end
