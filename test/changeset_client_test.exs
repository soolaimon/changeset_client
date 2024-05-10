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

      assert age.required == true
      assert age.range.min == 0
      assert age.range.max == 100

      name = Map.get(validations, :name)
      assert name.required == true
      assert name.length.min == 2
      assert name.length.max == 255
      assert name.length.message == "It's too short. Or too long. idk."

      length_is = Map.get(validations, :length_is)
      assert length_is.length.max == 5
      assert length_is.length.min == 5
    end
  end
end
