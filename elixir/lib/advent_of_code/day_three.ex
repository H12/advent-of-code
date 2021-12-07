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
    |> get_column_modes()
    |> Enum.join("")
    |> String.to_integer(2)
  end

  defp get_column_modes(binary_rows) do
    binary_rows
    |> Enum.map(&String.split(&1, "", trim: true))
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.map(&Enum.frequencies/1)
    |> Enum.map(&get_column_mode/1)
  end

  defp get_column_mode(%{"0" => zero_count, "1" => one_count}) do
    if zero_count > one_count do
      "0"
    else
      "1"
    end
  end

  defp get_column_mode(%{"0" => _}), do: "0"
  defp get_column_mode(%{"1" => _}), do: "1"

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

  @doc """
  Gets the "O2" from the provided input.

  ## Examples
      # After first pass, "011" is filtered out, and "100" on second
      iex> AdventOfCode.DayThree.get_o2_rating(["110", "011", "100"])
      6

      # Entries get filtered until only "10111" remains
      iex> AdventOfCode.DayThree.get_o2_rating([
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
      23
  """
  def get_o2_rating(binary_rows) do
    binary_rows
    |> filter_by_column(:max)
    |> String.to_integer(2)
  end

  @doc """
  Gets the "CO2" from the provided input.

  ## Examples
      # After first pass, "110" and "100" are filtered out.
      iex> AdventOfCode.DayThree.get_co2_rating(["110", "011", "100"])
      3

      # Entries get filtered until only "10111" remains
      iex> AdventOfCode.DayThree.get_co2_rating([
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
      10
  """
  def get_co2_rating(binary_rows) do
    binary_rows
    |> filter_by_column(:min)
    |> String.to_integer(2)
  end

  defp filter_by_column(binary_rows, :max), do: filter_by_column(binary_rows, 0, :max)
  defp filter_by_column(binary_rows, :min), do: filter_by_column(binary_rows, 0, :min)
  defp filter_by_column([single_row], _, _), do: single_row

  defp filter_by_column(binary_rows, column_index, min_or_max) do
    target_mode =
      binary_rows
      |> get_column_modes()
      |> Enum.at(column_index)

    binary_rows
    |> Enum.map(&String.split(&1, "", trim: true))
    |> Enum.filter(fn row -> Enum.at(row, column_index) == get_target(target_mode, min_or_max) end)
    |> Enum.map(&Enum.join/1)
    |> filter_by_column(column_index + 1, min_or_max)
  end

  defp get_target(target_mode, :max), do: target_mode
  defp get_target(target_mode, :min), do: to_string(1 - String.to_integer(target_mode))

  def parse_input(input) do
    input
    |> String.split("\n", trim: true)
  end
end
