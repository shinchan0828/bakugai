class CreateRequestTransitions < ActiveRecord::Migration[5.0]
  def change
    create_table :request_transitions do |t|
      t.string :to_state, null: false
      t.text :metadata
      t.integer :sort_key, null: false
      t.integer :request_id, null: false
      t.boolean :most_recent

      # If you decide not to include an updated timestamp column in your transition
      # table, you'll need to configure the `updated_timestamp_column` setting in your
      # migration class.
      t.timestamps null: false
    end

    # Foreign keys are optional, but highly recommended
    add_foreign_key :request_transitions, :requests

    add_index(:request_transitions,
              [:request_id, :sort_key],
              unique: true,
              name: "index_request_transitions_parent_sort")
    add_index(:request_transitions,
              [:request_id, :most_recent],
              unique: true,
              
              name: "index_request_transitions_parent_most_recent")
  end
end
