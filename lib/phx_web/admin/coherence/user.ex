defmodule PhxWeb.ExAdmin.Coherence.User do

  use ExAdmin.Register


  register_resource Phx.Coherence.User do

    index do

      selectable_column()

      column :id

      column :name

      actions()

    end

    filter [ :name, :email, :inserted_at, :updated_at ]

  end

end
