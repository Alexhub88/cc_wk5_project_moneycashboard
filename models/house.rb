require_relative('../db/sql_runner')

class House
  attr_reader :id
  attr_accessor :name, :url

  def initialize(house)
    @id = house['id'].to_s
    @name = house['name']
    @url= house['url']
  end

  def save
    sql = "INSERT INTO houses (name, url)
    VALUES ($1, $2)
    RETURNING id;"
    values = [@name, @url]
    @id = SqlRunner.run(sql, values).first["id"].to_i
  end

  def self.all
    sql = "SELECT * FROM houses"
    houses_hash = SqlRunner.run(sql)
    house_list = houses_hash.map{ |house| House.new(house)}
    return house_list
  end

end
