defmodule WorkdayReportsParallel.ParserTest do
  use ExUnit.Case

  @test_file "reports/workdays_1.csv"

  describe "parse_csv/1" do
    test "return parsed file" do
      sut =
        @test_file
        |> WorkdayReportsParallel.Parser.parse_csv()
        |> Enum.take(10)

      expected = [
        ["Daniele", 7, 29, 4, 2018],
        ["Mayk", 4, 9, 12, 2019],
        ["Daniele", 5, 27, 12, 2016],
        ["Mayk", 1, 2, 12, 2017],
        ["Giuliano", 3, 13, 2, 2017],
        ["Cleiton", 1, 22, 6, 2020],
        ["Giuliano", 6, 18, 2, 2019],
        ["Jakeliny", 8, 18, 7, 2017],
        ["Joseph", 3, 17, 3, 2017],
        ["Jakeliny", 6, 23, 3, 2019]
      ]

      assert sut == expected

      # validating string parser for number
      Enum.each(sut, fn [_name, hours, day, month, year] ->
        assert is_number(hours)
        assert is_number(day)
        assert is_number(month)
        assert is_number(year)
      end)
    end
  end
end
