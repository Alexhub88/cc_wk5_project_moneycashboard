require_relative('../db/sql_runner')

class TagType
  attr_reader :id, :type

  def initialize(tagtype)
    @id = tagtype['id'].to_i
    @type = tagtype['type']
  end

  def save
    sql = "INSERT INTO tagtypes (type)
    VALUES ($1)
    RETURNING id;"
    values = [@type]
    @id = SqlRunner.run(sql, values).first["id"].to_i
  end

  def self.all
    sql = "SELECT * FROM tagtypes"
    tagtypes_hash = SqlRunner.run(sql)
    tagtypes = tagtypes_hash.map {|tagtype| TagType.new(tagtype)}
    return tagtypes
  end

  def self.find( id )
    sql = "SELECT * FROM tagtypes WHERE id = $1"
    values = [id]
    result = SqlRunner.run( sql, values )
    tagtype = TagType.new( result.first )
    return tagtype
  end

  def self.delete_all()
    sql = "DELETE FROM tagtypes"
    SqlRunner.run( sql)
  end

end
