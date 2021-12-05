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

  @doc """
   Takes a string input containing two elements per line and turns it into a
   keyword list.
   """
  def to_keyword_list(input) do
    input
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&to_movement_tuple/1)
  end

  defp to_movement_tuple(movement_str) do
    [dir, dist] = String.split(movement_str)

    {String.to_atom(dir), String.to_integer(dist)}
  end

end
