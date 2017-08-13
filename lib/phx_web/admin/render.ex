defimpl ExAdmin.Render, for: Exfile.File do

  def to_string( file ) do

    path = Exfile.Phoenix.Helpers.exfile_path( file )

    ~s(<img style="max-width: 100%; max-height: 100px;" src="#{ path }" />)

  end

end
