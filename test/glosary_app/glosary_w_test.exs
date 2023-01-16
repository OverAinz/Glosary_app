defmodule GlosaryApp.GlosaryWTest do
  use GlosaryApp.DataCase

  alias GlosaryApp.GlosaryW

  describe "words" do
    alias GlosaryApp.GlosaryW.Word

    import GlosaryApp.GlosaryWFixtures

    @invalid_attrs %{description: nil, imagen: nil, name: nil}

    test "list_words/0 returns all words" do
      word = word_fixture()
      assert GlosaryW.list_words() == [word]
    end

    test "get_word!/1 returns the word with given id" do
      word = word_fixture()
      assert GlosaryW.get_word!(word.id) == word
    end

    test "create_word/1 with valid data creates a word" do
      valid_attrs = %{description: "some description", imagen: "some imagen", name: "some name"}

      assert {:ok, %Word{} = word} = GlosaryW.create_word(valid_attrs)
      assert word.description == "some description"
      assert word.imagen == "some imagen"
      assert word.name == "some name"
    end

    test "create_word/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = GlosaryW.create_word(@invalid_attrs)
    end

    test "update_word/2 with valid data updates the word" do
      word = word_fixture()
      update_attrs = %{description: "some updated description", imagen: "some updated imagen", name: "some updated name"}

      assert {:ok, %Word{} = word} = GlosaryW.update_word(word, update_attrs)
      assert word.description == "some updated description"
      assert word.imagen == "some updated imagen"
      assert word.name == "some updated name"
    end

    test "update_word/2 with invalid data returns error changeset" do
      word = word_fixture()
      assert {:error, %Ecto.Changeset{}} = GlosaryW.update_word(word, @invalid_attrs)
      assert word == GlosaryW.get_word!(word.id)
    end

    test "delete_word/1 deletes the word" do
      word = word_fixture()
      assert {:ok, %Word{}} = GlosaryW.delete_word(word)
      assert_raise Ecto.NoResultsError, fn -> GlosaryW.get_word!(word.id) end
    end

    test "change_word/1 returns a word changeset" do
      word = word_fixture()
      assert %Ecto.Changeset{} = GlosaryW.change_word(word)
    end
  end
end
