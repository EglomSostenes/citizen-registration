# frozen_string_literal: true

class CreateCitizens < ActiveRecord::Migration[7.0]
  def change
    create_table :citizens do |t|
      t.string :full_name
      t.string :cpf
      t.string :cns
      t.string :email
      t.string :phone
      t.date :birthday
      t.integer :status, default: 1

      t.timestamps
    end
  end
end
