defmodule PhxWeb.Coherence.Mailer do

  if Coherence.Config.mailer?() do

    use Swoosh.Mailer, otp_app: :coherence

  end

end
