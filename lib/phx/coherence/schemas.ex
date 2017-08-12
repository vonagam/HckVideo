defmodule Phx.Coherence.Schemas do

  use Coherence.Config

  import Ecto.Query

  alias Phx.Coherence.{ User, Invitation, Rememberable }


  @repo Config.repo


  def list_users do

    @repo.all( User )

  end

  def list_users( %Ecto.Query{} = query ) do

    @repo.all( query )

  end

  def get_user( id ) do

    @repo.get( User, id )

  end

  def get_user!( id ) do

    @repo.get!( User, id )

  end

  def get_user_by( opts ) do

    @repo.get_by( User, opts )

  end

  def get_user_by_email( email ) do

    @repo.get_by( User, email: email )

  end

  def change_user do

    User.changeset( %User{}, %{} )

  end

  def change_user( params ) do

    User.changeset( %User{}, params )

  end

  def change_user( user, params ) do

    User.changeset( user, params )

  end

  def create_user( params ) do

    @repo.insert( change_user( params ) )

  end

  def update_user( user, params ) do

    @repo.update( change_user( user, params ) )

  end

  def delete_user( user ) do

    @repo.delete( user )

  end


  def list_invitations do

    @repo.all( Invitation )

  end

  def list_invitations( %Ecto.Query{} = query ) do

    @repo.all( query )

  end

  def get_invitation( id ) do

    @repo.get( Invitation, id )

  end

  def get_invitation!( id ) do

    @repo.get!( Invitation, id )

  end

  def get_invitation_by( opts ) do

    @repo.get_by( Invitation, opts )

  end

  def change_invitation do

    Invitation.changeset( %Invitation{}, %{} )

  end

  def change_invitation( params ) do

    Invitation.changeset( %Invitation{}, params )

  end

  def change_invitation( invitation, params ) do

    Invitation.changeset( invitation, params )

  end

  def create_invitation( params ) do

    @repo.insert( change_invitation( params ) )

  end

  def update_invitation( invitation, params ) do

    @repo.update( change_invitation( invitation, params ) )

  end

  def delete_invitation( invitation ) do

    @repo.delete( invitation )

  end


  def list_rememberables do

    @repo.all( Rememberable )

  end

  def list_rememberables( %Ecto.Query{} = query ) do

    @repo.all( query )

  end

  def get_rememberable( id ) do

    @repo.get( Rememberable, id )

  end

  def get_rememberable!( id ) do

    @repo.get!( Rememberable, id )

  end

  def get_rememberable_by( opts ) do

    @repo.get_by( Rememberable, opts )

  end

  def change_rememberable do

    Rememberable.changeset( %Rememberable{}, %{} )

  end

  def change_rememberable( params ) do

    Rememberable.changeset( %Rememberable{}, params )

  end

  def change_rememberable( rememberable, params ) do

    Rememberable.changeset( rememberable, params )

  end

  def create_rememberable( params ) do

    @repo.insert( change_rememberable( params ) )

  end

  def update_rememberable( rememberable, params ) do

    @repo.update( change_rememberable( rememberable, params ) )

  end

  def delete_rememberable( rememberable ) do

    @repo.delete( rememberable )

  end


  def query_by( schema, opts ) do

    Enum.reduce opts, schema, fn { k, v }, query ->

      where( query, [ b ], field( b, ^k ) == ^v )

    end

  end

  def create( %Ecto.Changeset{} = changeset ) do

    @repo.insert( changeset )

  end

  def create!( %Ecto.Changeset{} = changeset ) do

    @repo.insert!( changeset )

  end

  def update( %Ecto.Changeset{} = changeset ) do

    @repo.update( changeset )

  end

  def update!( %Ecto.Changeset{} = changeset ) do

    @repo.update!( changeset )

  end

  def delete( schema ) do

    @repo.delete( schema )

  end

  def delete!( schema ) do

    @repo.delete!( schema )

  end

  def delete_all( %Ecto.Query{} = query ) do

    @repo.delete_all( query )

  end

  def delete_all( module ) when is_atom( module ) do

    @repo.delete_all( module )

  end

end
