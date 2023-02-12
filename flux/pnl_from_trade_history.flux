// expected columns
// id: trade id
// price: trade price
// size: trade size
// side: trade side

// price
import "math"

// required
bucket_name = "pbw"
measurement = "my_trades"

// optional
fee_rate = 0.0  // float

base = from (bucket: bucket_name)
    |> range(start: v.timeRangeStart, stop: v.timeRangeStop)
    |> sort(columns: ["_time"])
    |> filter(fn: (r) => r._measurement == measurement)

price = base
    |> filter(fn: (r) => r["_field"] == "price")
    |> keep(columns: ["_time", "_value", "id"])

size = base
    |> filter(fn: (r) => r._field == "size")
    |> map(fn: (r) => ({r with "_value": if r.side == "BUY" then r._value else r._value * -1.0}))
    |> keep(columns: ["_time", "_value", "id"])

df = join(tables: {price: price, size: size}, on:["id"])
    |> drop(columns: ["id", "_time_price"])
    |> rename(columns: {_time_size: "_time", _value_size: "size", _value_price: "price"})
    |> sort(columns: ["_time"])
    |> map(fn: (r) => ({r with vol: r.price * r.size * -1.0}))
    |> map(fn: (r) => ({r with fee: math.abs(x: r.vol) * fee_rate}))
    |> cumulativeSum(columns: ["vol", "size", "fee"])
    |> map(fn: (r) => ({"_time": r._time, "pnl": r.vol + r.size * r.price - r.fee}))
    |> yield()
