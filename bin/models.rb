require_relative '../lib/arl/sql_object'

class Cat < SQLObject
  self.finalize!

  belongs_to :human, foreign_key: :owner_id

  def owner
    self.human.name
  end
end

class Human < SQLObject
  self.table_name = 'humans'
  self.finalize!

  # belongs_to :house
  has_many :cats

  def name
    "#{@fname} #{@lname}"
  end
end

# class House < SQLObject
#   self.table_name = 'houses'
#   self.finalize!
#   has_many :humans
# end
