defmodule GlosaryApp.GlosaryWFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `GlosaryApp.GlosaryW` context.
  """

  @doc """
  Generate a word.
  """
  def word_fixture(attrs \\ %{}) do
    {:ok, word} =
      attrs
      |> Enum.into(%{
        description: "some description",
        imagen: "some imagen",
        name: "some name"
      })
      |> GlosaryApp.GlosaryW.create_word()

    word
  end
end
