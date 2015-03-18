module Searchable
  def where(params)
    cols, args = params.keys, params.values
    where_line = (cols.map { |col| "#{col} = ?" }).join(' AND ')
    data = DBConnection.execute(<<-SQL, *args)
      SELECT
        *
      FROM
        #{table_name}
      WHERE
        #{where_line}
    SQL

    parse_all(data)
  end
end
