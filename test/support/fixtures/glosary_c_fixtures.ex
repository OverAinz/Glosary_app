defmodule GlosaryApp.GlosaryCFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `GlosaryApp.GlosaryC` context.
  """

  @doc """
  Generate a category.
  """
  def category_fixture(attrs \\ %{}) do
    {:ok, category} =
      attrs
      |> Enum.into(%{
        description: "some description",
        name: "some name"
      })
      |> GlosaryApp.GlosaryC.create_category()

    category
  end
end
