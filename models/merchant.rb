require_relative('../db/sql_runner')

class Merchant
  attr_reader :id
  attr_accessor :name

  def initialize(merchant)
    @id = merchant['id'].to_i
    @name = merchant['name']
  end

  def save
    sql = "INSERT INTO merchants (name)
    VALUES ($1)
    RETURNING id;"
    values = [@name]
    @id = SqlRunner.run(sql, values).first["id"].to_i
  end

  def self.all
    sql = "SELECT * FROM merchants"
    merchants_hash = SqlRunner.run(sql)
    merchants = merchants_hash.map {|merchant| Merchant.new(merchant)}
    return merchants
  end

  def self.find( id )
    sql = "SELECT * FROM merchants WHERE id = $1"
    values = [id]
    result = SqlRunner.run( sql, values )
    merchant = Merchant.new( result.first )
    return merchant
  end

  def self.delete_all()
    sql = "DELETE FROM merchants"
    SqlRunner.run( sql)
  end

end
