# frozen_string_literal: true

[
    {
        id: 1,
        name: 'super_admin'
    },
    {
        id: 2,
        name: 'restuarant_owner'
    }
].each do |role|
    Role.create!(role)
end