module SortableByGivenScores
  extend ActiveSupport::Concern

  module ClassMethods
    def scores_as_recordset(scores, recordset_alias = :record_scoring)
      select_manager = Arel::SelectManager.new

      select_manager.from Arel::Nodes::NamedFunction.new(
        "json_populate_recordset", [
        Arel::Nodes::SqlLiteral.new("NULL::record_score"),
        Arel::Nodes::SqlLiteral.new("'#{
          ActiveSupport::JSON.encode(scores)
        }'")
      ])

      select_manager.project Arel.star
    end

    def by_given_scores(scores, recordset_alias = :record_scoring)
      # The generated recordset as a table-like sub-query:
      scoring_recordset = scores_as_recordset(scores).as "\"#{recordset_alias}\""

      # The join conditions to the generated recordset:
      join_condition = scoring_recordset
        .create_on(scoring_recordset[:id].eq(arel_table[:id]))

      join_clause = arel_table
        .create_join(scoring_recordset, join_condition, Arel::Nodes::InnerJoin)

      joins(join_clause).order(scoring_recordset[:score].desc)
    end
  end
end
