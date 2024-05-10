defmodule ChangesetClient do
  @moduledoc """
  Documentation for `ChangesetClient`.
  """

  alias Ecto.Changeset

  @doc """
  Hello world.

  ## Examples
     #defmodule FakeSchema do
     #   use Ecto.Schema
    # end

   #   iex> ChangesetClient.html_validations_for(%Ecto.Changeset{})
   #   :world

  """

  # required
  # min
  # max
  # minLength
  # maxLength
  # pattern
  # validate

  @spec validations_for(Ecto.Changeset.t()) :: %{}
  def validations_for(changeset) do
    required = Enum.map(changeset.required, &{&1, :required})

    validations =
      Enum.concat(required, Changeset.validations(changeset))
      |> Enum.map(fn {field, validation} ->
        {field, transform(validation)}
      end)
      |> then(fn validations ->
        fields = Keyword.keys(validations) |> Enum.uniq()

        Enum.map(fields, fn field ->
          field_validations = Keyword.get_values(validations, field)
          {field, Enum.into(field_validations, %{})}
        end)
      end)

    Enum.into(validations, %{})
    # Changeset.traverse_validations(changeset, fn {message, opts} ->
    #  {message, opts} |> dbg()
    # end)
  end

  defp transform({:inclusion, min..max}) do
    {:range, %{min: min, max: max}}
  end

  defp transform({:length, opts}) do
    {:length, %{min: opts[:min], max: opts[:max]}}
  end

  defp transform(:required), do: {:required, true}

  defp transform(val), do: val
end
