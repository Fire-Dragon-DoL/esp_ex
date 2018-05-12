defmodule EspEx.Handler do
  @moduledoc """
  Provides functionality to dispatch the event to the correct handle call.
  If no `handle` provided for the specific event, it will just be ignored and
  log the fact
  """

  @callback handle(
              entity :: EspEx.Entity.t(),
              event :: struct,
              raw_event :: EspEx.RawEvent.t()
            ) :: no_return()

  defmacro __using__(_) do
    quote do
      @behaviour unquote(__MODULE__)
      @before_compile EspEx.Handler.Unhandled
    end
  end
end
