module SortableByGivenScores
  extend ActiveSupport::Concern

  module ClassMethods
    def scores_as_recordset(scores, recordset_alias = :record_scoring)
      Arel::Nodes::NamedFunction.new(
        "json_populate_recordset", [
        Arel::Nodes::SqlLiteral.new("NULL::record_score"),
        Arel::Nodes::SqlLiteral.new("'#{
          ActiveSupport::JSON.encode(scores)
        }'")
      ]).as "\"#{recordset_alias}\""
    end

    def by_given_scores(scores, recordset_alias = :record_scoring)
      scoring = Arel::Table.new recordset_alias # Not a real table...
      scoring_recordset = scores_as_recordset(scores, recordset_alias)
      join_condition = scoring_recordset.create_on(scoring[:id].eq(arel_table[:id]))
      join_clause = arel_table
        .create_join(scoring_recordset, join_condition, Arel::Nodes::InnerJoin)
      joins(join_clause).order(scoring[:score].desc)
    end
  end
end
