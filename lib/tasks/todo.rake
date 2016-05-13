namespace :todo do
  desc "Deletes items older than 7 days"
  task delete_items: :environment do
    Item.delete_expired
  end

end
