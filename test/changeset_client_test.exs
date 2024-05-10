defmodule ChangesetClientTest do
  use ExUnit.Case

  import Ecto.Changeset

  doctest ChangesetClient

  # required
  # min
  # max
  # minLength
  # maxLength
  # pattern
  # validate

  defmodule FakeSchema do
    use Ecto.Schema
    import Ecto.Changeset

    embedded_schema do
      field(:integer_field, :integer)

      embeds_one :fake_embed, FakeEmbed do
        field(:embedded_integer_field)
      end
    end

    @doc false
    def changeset(schema, attrs) do
      schema
      |> cast(attrs, [
        :required_string,
        :integer_range
      ])
      |> cast_embed(:fake_embed, with: &fake_embed_changeset/2)
      |> validate_inclusion(:integer_range, 0..10)
      |> validate_required([:required_striing])
    end

    defp fake_embed_changeset(changeset, attrs) do
      changeset
      |> cast(attrs, [:embedded_integer_field])
      |> validate_inclusion(:embedded_integer_field, 0..10)
    end
  end

  describe "html_validations_for/1" do
    test "returns the html validations for the given changeset" do
      validations =
        FakeShema.changeset(%FakeSchema{}, %{}) |> ChangesetClient.html_validations_for()
    end
  end
end
