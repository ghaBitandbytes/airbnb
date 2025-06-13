class AddReviewsCountToProperties < ActiveRecord::Migration[7.1]
  def change
    # Add column with proper constraints
    add_column :properties, :reviews_count, :integer, default: 0, null: false
    
    # Backfill data (optimized SQL version)
    reversible do |dir|
      dir.up do
        if Review.table_exists?  # Safety check
          execute <<-SQL.squish
            UPDATE properties 
            SET reviews_count = (
              SELECT COUNT(*) 
              FROM reviews 
              WHERE reviews.property_id = properties.id
            )
          SQL
        end
      end
    end
  end
end