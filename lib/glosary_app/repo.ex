defmodule GlosaryApp.Repo do
  use Ecto.Repo,
    otp_app: :glosary_app,
    adapter: Ecto.Adapters.Postgres
end
