require_relative 'associatable'

module Associatable
  def has_one_through(name, through_name, source_name)

    through_options = assoc_options[through_name]
    define_method(name) do
      source_options = through_options.model_class.assoc_options[source_name]

      query_str = <<-SQL
        SELECT
          SRC.*
        FROM
          #{through_options.table_name} AS THG
        JOIN
          #{source_options.table_name} AS SRC
        ON
          SRC.#{source_options.primary_key} = THG.#{source_options.foreign_key}
        WHERE
          THG.#{through_options.primary_key} = ?
      SQL
      results =  DBConnection.execute(
        query_str,
        self.send(through_options.foreign_key)
      )

      results.map { |row_hash| source_options.model_class.new(row_hash) }.first
    end

  end
end
