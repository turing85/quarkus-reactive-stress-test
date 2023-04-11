local Animal = require("animal")

local headers = { ["Content-Type"] = "application/json;charset=UTF-8" }

request = function()
   return wrk.format("POST", "/animals", headers, Animal:new():json())
end

local microseconds_per_millisecond = 1000.0;

done = function(summary, latency, _)
    io.write("------------ CREATE ANIMALS ------------\n")
    io.write(string.format("total number of requests: %d\n", summary.requests));
    local status_symbol = summary.errors.status == 0 and "✅" or "❌"
    io.write(string.format(
            "Non-2xx responses: %d (%.2f%%) %s\n",
            summary.errors.status,
            summary.errors.status / summary.requests * 100,
            status_symbol))
    io.write("--------------- Latency ----------------\n")
    io.write(string.format(
            "      mean : %7d µs = %8.3f ms\n",
            latency.mean,
            latency.mean / microseconds_per_millisecond))
    io.write(string.format(
            "     stdev : %7d µs = %8.3f ms\n",
            latency.stdev,
            latency.stdev / microseconds_per_millisecond))
    io.write(string.format(
            "       min : %7d µs = %8.3f ms\n",
            latency.min,
            latency.min / microseconds_per_millisecond))
    io.write(string.format(
            "       max : %7d µs = %8.3f ms\n",
            latency.max,
            latency.max / microseconds_per_millisecond))
    io.write("Percentiles:\n")
    for _, p in pairs({ 0.001, 0.01, 0.1, 1, 10, 50, 90, 99, 99.9, 99.99, 99.999 }) do
        n = latency:percentile(p)
        io.write(string.format("  %7.3f%% : %7d µs = %8.3f ms\n", p, n, n / microseconds_per_millisecond))
    end
	io.write("----------------------------------------\n\n")
end