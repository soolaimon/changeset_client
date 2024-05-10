defmodule ChangesetClientTest do
  use ExUnit.Case, async: true
  # doctest ChangesetClient

  # required
  # min
  # max
  # minLength
  # maxLength
  # pattern
  # validate ??

  describe "validations_for/1" do
    test "returns the html validations for the given changeset" do
      expected = %{
        age: %{
          range: %{
            max: 10,
            min: 0
          },
          required: true
        }
      }

      # What about float ranges?
      # |> dbg()
      validations =
        FakeSchema.changeset(%FakeSchema{}, %{}) |> ChangesetClient.validations_for()

      assert age = Map.get(validations, :age)
      assert age.range.min == 0
      assert age.range.max == 100
      assert age.required == true
    end
  end
end
