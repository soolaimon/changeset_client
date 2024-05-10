defmodule ChangesetClient do
  @moduledoc """
  Documentation for `ChangesetClient`.
  """

  alias Ecto.Changeset

  @doc """
  Hello world.

  ## Examples

      iex> ChangesetClient.hello()
      :world

  """

  @spec html_validations_for(Ecto.Changeset.t()) :: %{}
  def html_validations_for(changeset) do
    Changeset.traverse_validations(changeset, fn {message, opts} ->
      {message, opts}
    end)
  end
end
