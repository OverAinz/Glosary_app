defmodule GlosaryAppWeb.CategoryController do
  use GlosaryAppWeb, :controller

  alias GlosaryApp.GlosaryC
  alias GlosaryApp.GlosaryC.Category

  action_fallback GlosaryAppWeb.FallbackController

  def index(conn, _params) do
    categories = GlosaryC.list_categories()
    render(conn, "index.json", categories: categories)
  end

  def create(conn, %{"category" => category_params}) do
    with {:ok, %Category{} = category} <- GlosaryC.create_category(category_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.category_path(conn, :show, category))
      |> render("show.json", category: category)
    end
  end

  def show(conn, %{"id" => id}) do
    category = GlosaryC.get_category!(id)
    render(conn, "show.json", category: category)
  end

  def update(conn, %{"id" => id, "category" => category_params}) do
    category = GlosaryC.get_category!(id)

    with {:ok, %Category{} = category} <- GlosaryC.update_category(category, category_params) do
      render(conn, "show.json", category: category)
    end
  end

  def delete(conn, %{"id" => id}) do
    category = GlosaryC.get_category!(id)

    with {:ok, %Category{}} <- GlosaryC.delete_category(category) do
      send_resp(conn, :no_content, "")
    end
  end
end
