use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :gather, GatherWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :gather, Gather.Repo,
  username: System.get_env("DB_USER"),
  password: System.get_env("DB_PASSWORD"),
  database: "gather_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
