defmodule ParkingLotTest do
  use ExUnit.Case, async: false
  import Mock
  import ExUnit.CaptureIO

  test "screate with enum" do
    parking_slots = [
      %{color: "WHITE", parking_no: 1, reg_num: "KA-01-HH-1234"},
      %{color: "BLACK", parking_no: 2, reg_num: "KA-01-HH-9999"},
      %{color: "RED", parking_no: 3, reg_num: "KA-01-BB-0001"},
      %{color: "BLUE", parking_no: 4, reg_num: "KA-01-HH-7777"},
      %{color: "WHITE", parking_no: 5, reg_num: "KA-01-HH-2701"},
      %{color: "WHITE", parking_no: 6, reg_num: "KA-01-HH-3141"}
    ]

    expected_result = [
      {%{color: "WHITE", parking_no: 1, reg_num: "KA-01-HH-1234"}, 1},
      {%{color: "BLACK", parking_no: 2, reg_num: "KA-01-HH-9999"}, 2},
      {%{color: "RED", parking_no: 3, reg_num: "KA-01-BB-0001"}, 3},
      {%{color: "BLUE", parking_no: 4, reg_num: "KA-01-HH-7777"}, 4},
      {%{color: "WHITE", parking_no: 5, reg_num: "KA-01-HH-2701"}, 5},
      {%{color: "WHITE", parking_no: 6, reg_num: "KA-01-HH-3141"}, 6}
    ]

    result = ParkingLot.convert_with_counter(parking_slots)
    assert result == expected_result
  end

  test "create parking lot" do
    value = "6"

    expected_result = [
      %{color: "WHITE", parking_no: 1, reg_num: "KA-01-HH-1234"},
      %{color: "BLACK", parking_no: 2, reg_num: "KA-01-HH-9999"},
      %{color: "RED", parking_no: 3, reg_num: "KA-01-BB-0001"},
      %{color: "BLUE", parking_no: 4, reg_num: "KA-01-HH-7777"},
      %{color: "WHITE", parking_no: 5, reg_num: "KA-01-HH-2701"},
      %{color: "WHITE", parking_no: 6, reg_num: "KA-01-HH-3141"}
    ]

    result = ParkingLot.create(value)
    assert result = expected_result
  end

  describe "create_parking_lot 6" do
    defmodule FakeIO do
      # defdelegate puts(message), to: IO
      def gets("Input "), do: "create_parking_lot 6"
    end

    test "get input from user" do
      expected_result = ["create_parking_slot", "6"]

      result = fn -> ParkingLot.get_input(FakeIO) end
      assert result
    end
  end

  describe "leave 4" do
    defmodule FakeIO do
      # defdelegate puts(message), to: IO
      def gets("Input "), do: "leave 4"
    end

    test "slot_number_for_registration_number" do
      expected_result = [
        {%{color: "WHITE", parking_no: 1, reg_num: "KA-01-HH-1234"}, 1},
        {%{color: "BLACK", parking_no: 2, reg_num: "KA-01-HH-9999"}, 2},
        {%{color: "RED", parking_no: 3, reg_num: "KA-01-BB-0001"}, 3},
        {%{color: "BLUE", parking_no: 4, reg_num: "KA-01-HH-7777"}, 4},
        {%{color: "WHITE", parking_no: 5, reg_num: "KA-01-HH-2701"}, 5},
        {%{color: "WHITE", parking_no: 6, reg_num: "KA-01-HH-3141"}, 6}
      ]

      ParkingLot.slot_number_for_registration_number(expected_result, "KA-01-HH-1234").FakeIO
    end
  end
end
