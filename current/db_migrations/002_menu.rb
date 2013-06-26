#
# Create user tables,
#
Sequel.migration do
  # For the up we want to create the table.
  up do
    # Create the user table with a primary key and a user name.
    create_table(:menus) do
      primary_key :id
      String :text
      String :target    # target link associated with the menu item
      Integer :parent   # id of the parent menu - 0 means top level menu item in the header
      Integer :weight   # higher number puts this item to the right of the screen
      Integer :secure   # must be logged in to see this item
      Integer :group    # if secure then only this user group can see the menu item - 0 means all
    end
  end

  # For the down we want to remove the table.
  down do
    drop_table(:menus)
  end
end
