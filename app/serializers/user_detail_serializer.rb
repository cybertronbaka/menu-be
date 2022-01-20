# frozen_string_literal: true

class UserDetailSerializer < ApplicationSerializer
  attributes(
    :id,
    :email,
    :mobile,
    :created_at,
    :updated_at
  )

  has_one :profile, key: :profile_attributes
  belongs_to :role, key: :role_attributes
end