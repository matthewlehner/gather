# Gather Analytics

To set up the app:

- Install dependencies with `mix deps.get`
- Edit the database configuration in `config/dev.exs` and `config/test.exs`
- Create and migrate your database with `mix ecto.setup`
- Install Node.js dependencies with `cd assets && yarn install`
- Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

# Database Configuration

```elixir
# Configure your database
config :gather, Gather.Repo,
  username: "my postgres user name", # Update this line!
  password: "my postgres password",  # and this one, too!
  database: "gather_dev",
  hostname: "localhost",
  pool_size: 10
```
