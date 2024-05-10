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
  #
  Includes message when possible

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

  @spec validations_for(Ecto.Changeset.t()) :: %{}
  def validations_for(changeset) do
    required = Enum.map(changeset.required, &{&1, :required})

    Changeset.traverse_validations(changeset, fn cs, field, {message, opts} ->
      nil
    end)

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

    Enum.into(validations, %{}) |> dbg()
    # Changeset.traverse_validations(changeset, fn {message, opts} ->
    #  {message, opts} |> dbg()
    # end)
  end

  defp transform({:inclusion, min..max}) do
    {:range, %{min: min, max: max}}
  end

  defp transform({:length, opts}) do
    case opts[:is] do
      nil -> {:length, %{min: opts[:min], max: opts[:max], message: opts[:message]}}
      is -> {:length, %{min: is, max: is, message: opts[:message]}}
    end
  end

  defp transform(:required), do: {:required, true}

  defp transform(val), do: val
end
