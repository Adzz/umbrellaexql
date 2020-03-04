defmodule WebServer.Router do
  use Phoenix.Router
  require Plug.Conn
  require Phoenix.Controller

  get("/healthcheck", WebServer.Controllers.HealthCheck, :index)

  pipeline :graphql do
    plug(Plug.Logger)
  end

  scope "/api" do
    pipe_through(:graphql)
    forward("/", Absinthe.Plug, schema: Graphql.Schema, json_codec: Jason)
  end

  if Mix.env() == :dev do
    forward("/graphiql", Absinthe.Plug.GraphiQL,
      schema: Graphql.Schema,
      json_codec: Jason,
      default_url: "/graphiql",
      interface: :advanced
    )
  end
end
