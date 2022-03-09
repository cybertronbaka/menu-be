# frozen_string_literal: true

module BroadcastHelper
  def to_gql_json
    new_hash = {}
    as_json.each_pair do |key, value|
      new_hash[key.to_s.camelize(:lower)] = value
    end
    new_hash
  end
end