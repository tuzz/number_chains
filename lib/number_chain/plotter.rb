module NumberChain
  module Plotter
    def self.plot(data, filename)
      data = data.map { |d| d.sort_by(&:-@) }

      contents = data.map.with_index do |point, index|
        row = "#{point.join(" ")} #{color(index, data.size)}"
      end.join("\n")

      datafile = Tempfile.new
      datafile.write(contents)
      datafile.close

      contents = instructions(datafile.path, "plot.gif", data)
      plotfile = Tempfile.new
      plotfile.write(contents)
      plotfile.close

      `gnuplot #{plotfile.path}`
    ensure
      datafile.unlink
      plotfile.unlink
    end

    def self.instructions(datapath, outpath, data)
      title = title(data)

      xs = data[1..-1].map { |d| d[0] }
      ys = data[1..-1].map { |d| d[1] }
      zs = data[1..-1].map { |d| d[2] }

      <<-GNU
        set term gif animate enhanced size 1024, 576 delay 3
        set output '#{outpath}'

        set title '#{title}'
        set xrange [0:#{xs.max}]
        set yrange [0:#{ys.max}]
        set zrange [0:#{zs.max}]
        set ticslevel 0
        set style line 1 lw 2 pt 7 ps 1
        set palette defined ( 0 "#cc33cc", 0.25 "#3333cc", 0.5 "#33cc33", 0.75 "#cccc33", 1 "#cc3333" )
        unset colorbox
        set border 15
        set grid xtics ytics ztics

        do for [i=1:360] {
          set view 45, (i + 100) % 360
          splot '#{datapath}' with linespoints ls 1 palette notitle
        }

        set output
      GNU
    end

    def self.color(index, size)
      magnitude = index.to_f / (size - 1)
      magnitude
    end

    def self.title(data)
      form = ("a".."z").take(data.first.length).join(" plus ")
      "The chain of length #{data.size} with the smallest start number for \"#{form}\""
    end
  end
end
