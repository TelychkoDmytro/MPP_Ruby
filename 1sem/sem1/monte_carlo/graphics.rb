require 'gnuplot'

module Graphics
  def plot_function(a: @a, b: @b)
    x_values = []
    y_values = []

    step = (b - a) / 100.0
    (a..b).step(step) do |x|
      x_values << x
      y_values << function(x)
    end

    Gnuplot.open do |gp|
      Gnuplot::Plot.new(gp) do |plot|
        plot.title("Function Plot")
        plot.xlabel "x"
        plot.ylabel "f(x)"

        plot.xrange "[#{a}:#{b}]"
        plot.yrange "[:*]"

        plot.data << Gnuplot::DataSet.new([x_values, y_values]) do |ds|
          ds.with = "lines"
          ds.notitle
        end
      end
    end
  end
end