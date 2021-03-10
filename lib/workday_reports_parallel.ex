defmodule WorkdayReportsParallel do
  alias WorkdayReportsParallel.Parser

  def call(file_names) when not is_list(file_names) or length(file_names) <= 0 do
    {:error, "argument is not a list, or is empty."}
  end

  def call(file_names) do
    case files_exists?(file_names) do
      false ->
        {:error, "one or more files were not found"}

      _ ->
        file_names
        |> Task.async_stream(fn file -> stream_to_list(file) end)
        |> merge_lists()
        |> Enum.reduce(report_default_map(), fn el, report -> sum_values(el, report) end)
    end
  end

  defp stream_to_list(file) do
    file
    |> Parser.parse_csv()
    |> Enum.map(& &1)
  end

  defp merge_lists(stream_lists) do
    stream_lists
    |> Enum.to_list()
    |> Keyword.values()
    |> Enum.reduce(fn e, acc -> acc ++ e end)
  end

  defp sum_values([name, hour, _day, month, year], %{
         all_hours: all_hours,
         hours_per_month: hours_per_month,
         hours_per_year: hours_per_year
       }) do
    all_hours = map_values(all_hours, name, hour)

    hours_per_month =
      hours_per_month
      |> Map.put(name, map_values(hours_per_month[name], get_month_name(month), hour))

    hours_per_year =
      hours_per_year
      |> Map.put(name, map_values(hours_per_year[name], year, hour))

    %{all_hours: all_hours, hours_per_month: hours_per_month, hours_per_year: hours_per_year}
  end

  defp report_default_map do
    %{all_hours: %{}, hours_per_month: %{}, hours_per_year: %{}}
  end

  defp map_values(map, key, hour) when not is_map(map) do
    Map.put(%{}, key, hour)
  end

  defp map_values(map, key, hour) when is_map(map) do
    Map.put(map, key, nil_to_number(map[key]) + hour)
  end

  def nil_to_number(value) when is_nil(value), do: 0
  def nil_to_number(value), do: value

  defp get_month_name(month_number) do
    months = %{
      1 => "janeiro",
      2 => "fevereiro",
      3 => "marco",
      4 => "abril",
      5 => "maio",
      6 => "junho",
      7 => "julho",
      8 => "agosto",
      9 => "setembro",
      10 => "outubro",
      11 => "novembro",
      12 => "dezembro"
    }

    months[month_number]
  end

  defp files_exists?(file_names) do
    file_names
    |> Enum.map(&File.exists?/1)
    |> Enum.all?(fn bool -> bool == true end)
  end
end
