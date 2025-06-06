# frozen_string_literal: true

module Types
  module Tpc
    class TpcSoftwareReportMetricComplianceCopyrightStatementType < Types::BaseObject
      field :include_copyrights, [String]
      field :not_included_copyrights, [String]
      field :oat_detail, [String]
    end
  end
end
