require_relative('../db/sql_runner')
require('pry')

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

  def self.find_by_name(name)
    sql = "SELECT * FROM merchants WHERE name = $1"
    values = [name]
    result = SqlRunner.run( sql, values )

  #  binding.pry


    first_result =  result.first
    if first_result != nil
      merchant = Merchant.new( first_result )
      return merchant
    else
      return nil
    end
  end

  def self.delete_all()
    sql = "DELETE FROM merchants"
    SqlRunner.run( sql)
  end

  def delete()
    sql = "DELETE FROM merchants
    WHERE id = $1"
    values = [@id]
    SqlRunner.run( sql, values )
  end

  def update()
    sql = "UPDATE merchants
    SET (name) = ($1)
    WHERE id = $2"
    values = [@name, @id]
    SqlRunner.run( sql, values )
  end

end
