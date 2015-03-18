class AssocOptions
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key
  )

  def model_class
    class_name.constantize
  end

  def table_name
    model_class.table_name
  end
end

class BelongsToOptions < AssocOptions
  def initialize(name, options = {})
    self.foreign_key = options[:foreign_key] || "#{name}_id".to_sym
    self.class_name = options[:class_name] || "#{name}".camelcase
    self.primary_key = options[:primary_key] || :id
  end
end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    foreign_key_sym = "#{self_class_name.underscore}_id".to_sym
    own_class_name = "#{name}".singularize.camelcase
    self.foreign_key = options[:foreign_key] || foreign_key_sym
    self.class_name = options[:class_name] || own_class_name
    self.primary_key = options[:primary_key] || :id
  end
end

module Associatable
  def belongs_to(name, options = {})
    options = BelongsToOptions.new(name, options)
    define_method(name) do
      foreign_key_value = send(options.foreign_key)
      options.model_class.where(id: foreign_key_value).first
    end
    assoc_options[name] = options
  end

  def has_many(name, options = {})
    options = HasManyOptions.new(name, to_s, options)
    define_method(name) do
      child = options.class_name.constantize
      child.where(options.foreign_key => id)
    end
  end

  def assoc_options
    @assoc_options ||= {}
    @assoc_options
  end
end

module Associatable
  def has_one_through(name, through_name, source_name)
    define_method(name) do
      through_opts = self.class.assoc_options[through_name]
      source_opts = through_opts.model_class.assoc_options[source_name]
      self_table = self.class.table_name
      through_table = through_opts.table_name
      source_table = source_opts.table_name

      house = DBConnection.execute(<<-SQL, id)
        SELECT
          #{source_table}.*
        FROM
          #{self_table}
        JOIN
          #{through_table}
        ON
          #{through_table}.id = #{through_opts.foreign_key}
        JOIN
          #{source_table}
        ON
          #{source_table}.id = #{source_opts.foreign_key}
        WHERE
          #{self_table}.id = ?
      SQL

      source_opts.model_class.new(house.first)
    end
  end
end
