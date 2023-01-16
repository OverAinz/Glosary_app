defmodule GlosaryApp.GlosaryC do
  @moduledoc """
  The GlosaryC context.
  """

  import Ecto.Query, warn: false
  alias GlosaryApp.Repo
  alias EctoPaginator
  alias GlosaryApp.GlosaryC.Category

  @doc """
  Returns the list of categories.

  ## Examples

      iex> list_categories()
      [%Category{}, ...]

  """
  def list_categories do
    Repo.all(Category)
  end


  def list_categories_pagination(page, size) do
    query = from u in Category, select: u, order_by: [asc: u.name]
    nusers = Repo.all(query) |> Enum.count()
    pages = nusers/String.to_integer(size)
    res = rem(nusers, String.to_integer(size))
    fpag = get_pages(pages, res) |> trunc
    categories = query
    |> EctoPaginator.paginate(String.to_integer(page), String.to_integer(size))
    |> Repo.all()

    %{pages: to_string(fpag), data: categories}
  end

  def list_categories_pagination_order(page, size, order_by) do

    query = order(order_by)
    nusers = Repo.all(query) |> Enum.count()
    pages = nusers/String.to_integer(size)
    res = rem(nusers, String.to_integer(size))
    fpag = get_pages(pages, res) |> trunc
    categories = query
    |> EctoPaginator.paginate(String.to_integer(page), String.to_integer(size))
    |> Repo.all()

    %{pages: to_string(fpag), data: categories}
  end

  defp order(order_by) do
    case order_by do
      "last" -> from u in Category, select: u, order_by: [desc: u.inserted_at]
      "first" -> from u in Category, select: u, order_by: [asc: u.inserted_at]
    end
  end

  defp get_pages(pages, res) do
    repages = if (res > 0) do
      pages = pages + 1
      pages
    else
      pages
    end
    repages
  end


  @doc """
  Gets a single category.

  Raises `Ecto.NoResultsError` if the Category does not exist.

  ## Examples

      iex> get_category!(123)
      %Category{}

      iex> get_category!(456)
      ** (Ecto.NoResultsError)

  """
  def get_category!(id), do: Repo.get!(Category, id)

  def get_by_name(name) do
    query = from u in Category, where: u.name == ^name

    case Repo.one(query) do
      nil -> {:error, :not_found}
      category -> {:ok, category}
    end
  end

  @doc """
  Creates a category.

  ## Examples

      iex> create_category(%{field: value})
      {:ok, %Category{}}

      iex> create_category(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_category(attrs \\ %{}) do
    %Category{}
    |> Category.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a category.

  ## Examples

      iex> update_category(category, %{field: new_value})
      {:ok, %Category{}}

      iex> update_category(category, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_category(%Category{} = category, attrs) do
    category
    |> Category.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a category.

  ## Examples

      iex> delete_category(category)
      {:ok, %Category{}}

      iex> delete_category(category)
      {:error, %Ecto.Changeset{}}

  """
  def delete_category(%Category{} = category) do
    Repo.delete(category)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking category changes.

  ## Examples

      iex> change_category(category)
      %Ecto.Changeset{data: %Category{}}

  """
  def change_category(%Category{} = category, attrs \\ %{}) do
    Category.changeset(category, attrs)
  end
end
