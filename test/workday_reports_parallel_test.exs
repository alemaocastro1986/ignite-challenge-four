defmodule WorkdayReportsParallelTest do
  use ExUnit.Case

  @file_names ["reports/workdays_1.csv"]

  describe "call/1" do
    test "return a formated report" do
      assert %{all_hours: all, hours_per_month: per_month, hours_per_year: per_year} =
               WorkdayReportsParallel.call(@file_names)

      assert all == %{
               "Cleiton" => 4497,
               "Daniele" => 4428,
               "Danilo" => 4722,
               "Diego" => 4401,
               "Giuliano" => 4473,
               "Jakeliny" => 4656,
               "Joseph" => 4219,
               "Mayk" => 4404,
               "Rafael" => 4388,
               "Vinicius" => 4587
             }

      assert per_month["Cleiton"] == %{
               "abril" => 346,
               "agosto" => 391,
               "dezembro" => 339,
               "fevereiro" => 385,
               "janeiro" => 376,
               "julho" => 355,
               "junho" => 392,
               "maio" => 410,
               "marco" => 295,
               "novembro" => 374,
               "outubro" => 396,
               "setembro" => 438
             }

      assert per_year["Cleiton"] == %{
               2016 => 852,
               2017 => 825,
               2018 => 924,
               2019 => 906,
               2020 => 990
             }
    end

    test "return error when argument not is an list, or is an empty list" do
      assert {:error, message} = WorkdayReportsParallel.call("")
      assert message == "argument is not a list, or is empty."
    end

    test "return error when a file is not found in the list" do
      assert {:error, message} =
               WorkdayReportsParallel.call(["non-exist.csv", "reports/workdays_1.csv"])

      assert message == "one or more files were not found"
    end
  end
end
