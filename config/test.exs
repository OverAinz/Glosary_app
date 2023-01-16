import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :glosary_app, GlosaryApp.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "glosary_app_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :glosary_app, GlosaryAppWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "kRrXm/QpEZUpOiq0dBOhUcXFjB9OT1RiBhgK3tyFA4D/XkO9RFckzpK1zYXIJfwg",
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
