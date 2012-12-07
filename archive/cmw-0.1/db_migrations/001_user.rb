#
# Create user table,
#
Sequel.migration do
  # For the up we want to create the table.
  up do
    # Create the user table with a primary key and a user name.
    create_table(:users) do
      primary_key :id
      String :login, :unique=>true
      String :email, :unique=>true
      String :crypted_password 
      String :password_salt
      String :first_name
      String :last_name
      String :street_number
      String :street_name
      String :suburb
      String :country_state
      String :country
      String :postcode
      Integer :day_of_birth
      Integer :month_of_birth
      Integer :year_of_birth
      # next is for Junior, Senior Kyu, Dan
      Integer :grade_category
    end
  end

  # For the down we want to remove the table.
  down do
    drop_table(:users)
  end
end
