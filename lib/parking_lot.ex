defmodule ParkingLot do
  @moduledoc """
  Documentation for Parking.
  """

  def start(parking_lots) do
    input = get_input()

    cond do
      length(input) == 1 ->
        one(input, parking_lots)

      length(input) == 2 ->
        two(input, parking_lots)

      length(input) == 3 ->
        three(input, parking_lots)

      true ->
        IO.puts("Invalid")
        ParkingLot.start(parking_lots)
    end
  end

  def one(input, parking_lots) do
    [command] = input

    cond do
      command == "status" ->
        status(parking_lots)

      command == "exit" or "Exit" ->
        System.halt()

      true ->
        IO.puts("Invalid Input")
        ParkingLot.start(parking_lots)
    end
  end

  def two(input, parking_lots) do
    [command, value] = input

    cond do
      command == "create_parking_lot" ->
        parking_lots = create(value)
        parking_lots = parking_lots

        if length(parking_lots) > 0 do
          ParkingLot.start(convert_with_counter(parking_lots))
        end

      command == "leave" ->
        leave(parking_lots, value)

      command == "registration_numbers_for_cars_with_colour" ->
        registration_numbers_for_cars_with_colour(parking_lots, value)

      command == "slot_numbers_for_cars_with_colour" ->
        slot_numbers_for_cars_with_colour(parking_lots, value)

      command == "slot_number_for_registration_number" ->
        slot_number_for_registration_number(parking_lots, value)

      true ->
        IO.puts("Invalid Input")
        ParkingLot.start(parking_lots)
    end
  end

  def three(input, parking_lots) do
    [command, value1, value2] = input

    cond do
      command == "park" ->
        park(parking_lots, value1, value2)

      true ->
        IO.puts("Invalid Input")
        ParkingLot.start(parking_lots)
    end
  end

  def slot_number_for_registration_number(parking_lots, value) do
    result = Enum.filter(parking_lots, fn {x, _} -> x.reg_num == value end)

    if length(result) > 0 do
      for {x, _} <- result do
        IO.puts(x.parking_no)
      end
    else
      IO.puts("Not Found")
    end

    ParkingLot.start(parking_lots)
  end

  def slot_numbers_for_cars_with_colour(parking_lots, color) do
    result = Enum.filter(parking_lots, fn {x, _} -> x.color == color end)

    if length(result) > 0 do
      for {x, _} <- result do
        IO.puts(x.parking_no)
      end
    else
      IO.puts("Not Found")
    end

    ParkingLot.start(parking_lots)
  end

  def registration_numbers_for_cars_with_colour(parking_lots, color) do
    result = Enum.filter(parking_lots, fn {x, _} -> x.color == color end)

    if length(result) > 0 do
      for {x, _} <- result do
        IO.puts("Allocated slot number: #{x.reg_num}")
      end
    else
      IO.puts("Not Found")
    end

    ParkingLot.start(parking_lots)
  end

  def status(parking_lots) do
    cond do
      !is_bitstring(parking_lots) ->
        IO.puts("Slot No.   Registration No   Colour")

        for {x, y} <- parking_lots do
          if x.reg_num != "" do
            IO.puts("#{y}           #{x.reg_num}     #{x.color}")
          end
        end

        ParkingLot.start(parking_lots)

      true ->
        IO.puts("Parking slot is not initiated")
        ParkingLot.start(parking_lots)
    end
  end

  def get_input() do
    IO.gets("Input: \n")
    |> String.split()
  end

  def create(value) do
    {num, ""} = Integer.parse(value)
    IO.puts("Created a parking lot with #{num} slots")
    list = Enum.to_list(1..num)
    Enum.map(list, fn _ -> %{color: "", parking_no: 0, reg_num: ""} end)
  end

  def park(parking_lots, reg_no, colour) do
    empty_slots = Enum.filter(parking_lots, fn {x, _} -> x.parking_no == 0 end)

    cond do
      length(empty_slots) > 0 ->
        empty_slot = Enum.uniq_by(empty_slots, fn {x, _} -> x.parking_no end)

        for {_, y} <- empty_slot do
          parking_lots =
            List.update_at(parking_lots, y - 1, fn {_, _} ->
              {%{color: colour, parking_no: y, reg_num: reg_no}, y}
            end)

          IO.puts("Allocated slot number: #{y}")
          ParkingLot.start(parking_lots)
        end

      true ->
        IO.puts("Sorry, parking lot is full")
        ParkingLot.start(parking_lots)
    end
  end

  def leave(parking_lots, value) do
    cond do
      !is_bitstring(parking_lots) ->
        {slot, ""} = Integer.parse(value)

        for {_, y} <- parking_lots do
          if y == slot do
            parking_lots =
              List.update_at(parking_lots, slot - 1, fn {_, _} ->
                {%{color: "", parking_no: 0, reg_num: ""}, slot}
              end)

            IO.puts("Slot number #{slot} is free")
            ParkingLot.start(parking_lots)
          end
        end

      true ->
        IO.puts("Sorry, parking slot is not initiated")
        ParkingLot.start(parking_lots)
    end
  end

  def convert_with_counter(parking_lots) do
    Enum.with_index(parking_lots, 1)
  end
end
