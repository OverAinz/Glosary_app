defmodule GlosaryAppWeb.CategoryView do
  use GlosaryAppWeb, :view
  alias GlosaryAppWeb.CategoryView

  def render("index.json", %{categories: categories}) do
    %{data: render_many(categories, CategoryView, "category.json")}
  end

  def render("index_pag.json", %{categories: categories, pages: pages}) do
    %{data: render_many(categories, CategoryView, "category.json"), pages: pages}
  end

  def render("show.json", %{category: category}) do
    %{data: render_one(category, CategoryView, "category.json")}
  end

  def render("category.json", %{category: category}) do
    %{
      id: category.id,
      name: category.name,
      description: category.description
    }
  end
end
