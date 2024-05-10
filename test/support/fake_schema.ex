defmodule FakeSchema do
  @moduledoc """
  A fake schema for testing purposes.
  """

  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :age, :integer
    field :name, :string
    field :length_is, :string
    field :plain_required_one, :string
    field :inclusion_field

    embeds_one :fake_embed, FakeEmbed do
      field :embedded_embedded_age, :integer
    end
  end

  @doc false
  def changeset(schema, attrs) do
    schema
    |> cast(attrs, [
      :name,
      :age
    ])
    |> cast_embed(:fake_embed, with: &fake_embed_changeset/2)
    |> validate_inclusion(:age, 0..100, message: "must be between 0 and 100")
    |> validate_length(:name, min: 2, max: 255, message: "It's too short. Or too long. idk.")
    |> validate_length(:length_is, is: 5, message: "Length must be 5")
    |> validate_inclusion(:inclusion_field, ["a", "b", "c"], message: "must be a, b, or c")
    |> validate_required([:name, :plain_required_one, :age])
  end

  defp fake_embed_changeset(changeset, attrs) do
    changeset
    |> cast(attrs, [:embedded_integer_field])
    |> validate_inclusion(:embedded_integer_field, 0..10)
  end

  # validate_acceptance/3
  # validate_confirmation/3
  # validate_exclusion/4
  # validate_format/4
  # validate_inclusion/4
  # validate_length/3
  # validate_number/3
  # validate_required/3
  # validate_subset/4
  # validations/1
end
