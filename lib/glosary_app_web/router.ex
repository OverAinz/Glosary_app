defmodule GlosaryAppWeb.Router do
  use GlosaryAppWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug PrimaAuth0Ex.Plug.VerifyAndValidateToken, audience: "https://dev-jdbh0t3oewrxreto.us.auth0.com/api/v2/", required_permissions: []
  end

  scope "/api", GlosaryAppWeb do
    pipe_through :api

    get "/public", TestController, :test
  end

  scope "/api", GlosaryAppWeb do
    pipe_through [:api, :auth]

    get "/private", TestController, :testp
  end


end
