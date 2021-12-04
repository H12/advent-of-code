defmodule Helpers do
  @moduledoc """
  Some helper functions for working with advent of code input.
  """

  @doc """
  Takes string input and converts it into a list of integers.

  Assumes separators are newlines.
  """
  def to_int_list(input) do
    input
    |> String.split()
    |> Enum.map(&String.to_integer/1)
  end
end
