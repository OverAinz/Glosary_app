defmodule GlosaryApp.GlosaryW.Word do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "words" do
    field :description, :string
    field :imagen, :string
    field :name, :string
    #field :category_id, :binary_id
    belongs_to :category, GlosaryApp.GlosaryC.Category

    timestamps()
  end

  @doc false
  def changeset(word, attrs) do
    word
    |> cast(attrs, [
      :name,
      :description,
      :imagen])
    |> validate_required([
      :name,
      :description,
      :imagen])
    |> unique_constraint(:name)
  end

end
