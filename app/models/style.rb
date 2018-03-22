class Style < ApplicationRecord
  belongs_to :stylable, :polymorphic => true
end
