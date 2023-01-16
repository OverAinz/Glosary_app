defmodule GlosaryAppWeb.CategoryController do
  use GlosaryAppWeb, :controller

  alias GlosaryApp.GlosaryC
  alias GlosaryApp.GlosaryC.Category

  action_fallback GlosaryAppWeb.FallbackController

  def index(conn, _params) do
    categories = GlosaryC.list_categories()
    render(conn, "index.json", categories: categories)
  end

  def index_pag(conn, %{"page" => page, "size" => size}) do
    %{pages: pages, data: categories} = GlosaryC.list_categories_pagination(page, size)
    render(conn, "index_pag.json", categories: categories, pages: pages)
  end

  def index_pag_order(conn, %{"page" => page, "size" => size, "order_by" => order_by}) do
    %{pages: pages, data: categories} = GlosaryC.list_categories_pagination_order(page, size, order_by)
    render(conn, "index_pag.json", categories: categories, pages: pages)
  end


  def create(conn, %{"category" => category_params}) do
    with {:ok, %Category{} = category} <- GlosaryC.create_category(category_params) do
      conn
      |> put_status(:created)
      |> render("show.json", category: category)
    end
  end

  def show(conn, %{"id" => id}) do
    category = GlosaryC.get_category!(id)
    render(conn, "show.json", category: category)
  end

  def by_name(conn, %{"name" => name}) do
    {:ok, category} = GlosaryC.get_by_name(name)
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
