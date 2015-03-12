class Fixtures
  def self.create
    build_dog_house_fixture
    improve_backyard_fixture
    paint_house_fixture
  end

  def self.build_dog_house_fixture
    p              = Project.new
    p.description  = 'Build dog house'
    p.image        = File.open(File.expand_path("../assets/doghouse.png", File.dirname(__FILE__))).read
    t1             = Task.new
    t1.description = 'Buy wood at store'
    t1.priority    = 'H'
    t1.project     = p
    r1 = Resource.new
    r1.description = 'regular wood'
    r1.cost        = 100.5
    r2 = Resource.new
    r2.description = 'a good hammer'
    r2.cost        = 25
    t1.resources << r1 << r2
    t2             = Task.new
    t2.description = 'Ask Mike for his toolbox'
    t2.project     = p
    t2.priority    = 'M'
    t3             = Task.new
    t3.description = 'Find the lost metric tape'
    t3.completed   = true
    t3.project     = p
    t3.priority    = 'M'
  end

  def self.improve_backyard_fixture
    p              = Project.new
    p.description  = 'Improve backyard'
    p.image        = File.open(File.expand_path("../assets/backyard.png", File.dirname(__FILE__))).read
    t1             = Task.new
    t1.description = 'Cut grass'
    t1.project     = p
    t1.priority    = 'L'
    t1.due_by      = Date.today + 30
    t2             = Task.new
    t2.description = 'Water roses'
    t2.project     = p
    t2.priority    = 'M'
    t2.due_by      = Date.today + 2
    t3             = Task.new
    t3.description = 'Pickup dog stuff'
    t3.project     = p
    t3.priority    = 'L'
  end

  def self.paint_house_fixture
    p              = Project.new
    p.description  = 'Paint house'
    p.image        = File.open(File.expand_path("../assets/paint_house.png", File.dirname(__FILE__))).read
    t1             = Task.new
    t1.description = 'Buy 4 lts. of white paint'
    t1.project     = p
    t1.priority    = 'H'
    t2             = Task.new
    t2.description = 'Rent a ladder at hardware store'
    t2.project     = p
    t2.priority    = 'H'
    t3             = Task.new
    t3.description = 'Start painting lateral wall first'
    t3.project     = p
    t3.priority    = 'M'
  end
end
