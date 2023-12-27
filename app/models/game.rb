# frozen_string_literal: true

class Game < ApplicationRecord
  has_many :players, dependent: :destroy
end

# == Schema Information
#
# Table name: games
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
