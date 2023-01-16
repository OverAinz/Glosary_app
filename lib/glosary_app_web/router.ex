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
    resources "/categories", CategoryController, except: [:new, :edit]
    get "/categories/by_name/:name", CategoryController, :by_name
    get "/categories/pagination/:page/:size", CategoryController, :index_pag
    get "/categories/pagination/:page/:size/:order_by", CategoryController, :index_pag_order

    resources "/words", WordController, except: [:new, :edit]
    get "/words/by_category/:category_id", WordController, :by_category
  end

  scope "/api", GlosaryAppWeb do
    pipe_through [:api, :auth]

    get "/private", TestController, :testp
  end


end
