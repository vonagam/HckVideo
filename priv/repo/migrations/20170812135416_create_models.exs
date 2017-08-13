defmodule Phx.Repo.Migrations.CreateModels do

  use Ecto.Migration


  def change do

    create table( :cities ) do

      add( :slug, :string, null: false )

      add( :name, :string, null: false )

      add( :description, :text )

      add( :image, :string )

      add( :coordinates, { :array, :float } )

    end

    create( index( :cities, [ :slug ], unique: true ) )


    create table( :groups ) do

      add( :slug, :string, null: false )

      add( :name, :string, null: false )

      add( :description, :text )

      add( :image, :string )

    end

    create( index( :groups, [ :slug ], unique: true ) )


    create table( :persons ) do

      add( :slug, :string, null: false )

      add( :name, :string, null: false )

      add( :description, :text )

      add( :image, :string )

    end

    create( index( :persons, [ :slug ], unique: true ) )


    create table( :types ) do

      add( :slug, :string, null: false )

      add( :name, :string, null: false )

      add( :description, :text )

      add( :image, :string )

    end

    create( index( :types, [ :slug ], unique: true ) )


    create table( :videos ) do

      add( :url, :string, null: false )

      add( :title, :string )

      add( :description, :text )

      add( :date, :utc_datetime, null: false )

      add( :coordinates, { :array, :float } )

      add( :subjects, :map, null: false )

      add( :views, :integer )

      add( :visible, :boolean, null: false, default: true ) # for hackaton it is true

    end

    create( index( :videos, [ :url ], unique: true ) )

    create( index( :videos, [ :date ] ) )

    create( index( :videos, [ :subjects ], using: :gin ) )

    create( index( :videos, [ :views ] ) )

    create( index( :videos, [ :visible ] ) )

  end

end
