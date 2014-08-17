class CamelBanana
  def initialize(banana=3000, total_distance=1000, capacity=1000)
    @banana = banana
    @total_distance = total_distance
    @capacity = capacity
  end

  def maximum
    path=[]
    distance = passed_distance =0
    path << [distance, @banana]
    while @banana > 0 && @total_distance != passed_distance
      # determine next distance
      fuel = fuel_per_mile(@banana)
      @banana = @banana - @capacity
      if fuel == 1
        distance = @total_distance-passed_distance
        passed_distance += distance
        path << [distance, path[-1].last-distance]
      else
        distance = (@capacity/fuel.to_f).ceil
        passed_distance += distance
        path << [distance, banana_at_distance(path[-1].last, distance)]
      end
      puts "#{path[-1].last} Banana at distance #{passed_distance}"
    end
    puts path.inspect
    path[-1].last
  end

  private ##################################

  def fuel_per_mile(banana, i=0, s=true)
    if banana > 0 && s
      fuel_per_mile(banana-@capacity,i+1,false)
    elsif !s && banana > 0
      fuel_per_mile(banana,i+1)
    else
      i
    end
  end

  def banana_at_distance(banana, distance, loaded=0)
    if banana > 0
      if banana > @capacity
        banana_at_distance(banana-@capacity, distance, loaded + @capacity - (distance*2))
      else
        banana_at_distance(0, distance, loaded + banana - distance)
      end
    else
      loaded
    end
  end
end
