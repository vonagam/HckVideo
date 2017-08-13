defmodule PhxWeb.ExAdmin.Models.City do

  use ExAdmin.Register


  register_resource Phx.Models.City do

    form city do

      inputs do

        input( city, :slug )

        input( city, :name )

        input( city, :description )

        input( city, :image )

      end

    end

  end

end
