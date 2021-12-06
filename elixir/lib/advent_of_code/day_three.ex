defmodule AdventOfCode.DayThree do
  use Bitwise

  @doc """
  Gets the "gamma" from the provided input.

  ## Examples
      # Most common bits are "110", or 6 in decimal
      iex> AdventOfCode.DayThree.get_gamma(["110", "011", "100"])
      6

      # Most common bits are "10110", or 22 in decimal
      iex> AdventOfCode.DayThree.get_gamma([
      ...>   "00100",
      ...>   "11110",
      ...>   "10110",
      ...>   "10111",
      ...>   "10101",
      ...>   "01111",
      ...>   "00111",
      ...>   "11100",
      ...>   "10000",
      ...>   "11001",
      ...>   "00010",
      ...>   "01010"
      ...> ])
      22
  """
  def get_gamma(binary_rows) do
    binary_rows
    |> Enum.map(&String.split(&1, "", trim: true))
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.map(&Enum.frequencies/1)
    |> Enum.map(&Enum.max_by(&1, fn {_, count} -> count end))
    |> Enum.map(&elem(&1, 0))
    |> Enum.join("")
    |> String.to_integer(2)
  end

  @doc """
  Gets the "epsilon" from the provided input.

  ## Examples
      # Least common bits are "001", or 1 decimal
      iex> AdventOfCode.DayThree.get_epsilon(["110", "011", "100"])
      1

      # Lease common bits are "01001", or 9 in decimal
      iex> AdventOfCode.DayThree.get_epsilon([
      ...>   "00100",
      ...>   "11110",
      ...>   "10110",
      ...>   "10111",
      ...>   "10101",
      ...>   "01111",
      ...>   "00111",
      ...>   "11100",
      ...>   "10000",
      ...>   "11001",
      ...>   "00010",
      ...>   "01010"
      ...> ])
      9
  """
  def get_epsilon(binary_rows = [hd | _]) do
    # Max is a binary 1 bitshifted left by the size of each bit string, minus 1
    # E.g. for `hd` of "101", `max` is `(1 <<< 3) - 1`, or `1000 - 1`, or `111`
    max = (1 <<< byte_size(hd)) - 1

    # Epsilon is the max minus gamma
    max - get_gamma(binary_rows)
  end

  def parse_input(input) do
    String.split(input, "\n", trim: true)
  end
end
