require_relative '../lib/arl/sql_object'

class Cat < SQLObject
  self.finalize!

  belongs_to :owner, class_name: 'Human', foreign_key: :owner_id
end

class Human < SQLObject
  self.table_name = 'humans'
  self.finalize!

  has_many :cats

  def name
    "#{fname} #{lname}"
  end
end
