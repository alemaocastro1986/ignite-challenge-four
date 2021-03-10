defmodule WorkdayReportsParallel.Parser do
  def parse_csv(file_name) do
    file_name
    |> File.stream!()
    |> Stream.map(&parse_row(&1))
  end

  defp parse_row(row) do
    row
    |> String.trim()
    |> String.split(",")
    |> List.update_at(1, &String.to_integer(&1))
    |> List.update_at(2, &String.to_integer(&1))
    |> List.update_at(3, &String.to_integer(&1))
    |> List.update_at(4, &String.to_integer(&1))
  end
end
