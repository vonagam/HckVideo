defmodule Phx.Repo.Migrations.CreateCoherenceUser do

  use Ecto.Migration


  def change do

    create table( :users ) do

      add( :name, :string )

      add( :email, :string )

      # authenticatable

      add( :password_hash, :string )

      # rememberable

      add( :remember_created_at, :utc_datetime )

      # trackable

      add( :sign_in_count, :integer, default: 0 )

      add( :current_sign_in_at, :utc_datetime )

      add( :last_sign_in_at, :utc_datetime )

      add( :current_sign_in_ip, :string )

      add( :last_sign_in_ip, :string )

      # confirmable

      add( :confirmation_token, :string )

      add( :confirmed_at, :utc_datetime )

      add( :confirmation_sent_at, :utc_datetime )

      # recoverable

      add( :reset_password_token, :string )

      add( :reset_password_sent_at, :utc_datetime )

      # lockable

      add( :failed_attempts, :integer, default: 0 )

      add( :locked_at, :utc_datetime )

      # unlockable_with_token

      add( :unlock_token, :string )

      timestamps()

    end

    create( index( :users, [ :email ], unique: true ) )


    create table( :rememberables ) do

      add( :series_hash, :string )

      add( :token_hash, :string )

      add( :token_created_at, :datetime )

      add( :user_id, references( :users, on_delete: :delete_all ) )

      timestamps()

    end

    create( index( :rememberables, [ :user_id ] ) )

    create( index( :rememberables, [ :series_hash ] ) )

    create( index( :rememberables, [ :token_hash ] ) )

    create( index( :rememberables, [ :user_id, :series_hash, :token_hash ], unique: true ) )


    create table( :invitations ) do

      add( :name, :string )

      add( :email, :string )

      add( :token, :string )

      timestamps()

    end

    create( index( :invitations, [ :email ], unique: true ) )

    create( index( :invitations, [ :token ] ) )

  end

end
