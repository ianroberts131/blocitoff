#Blocitoff
This is the first application I built as part of Bloc's Rails Web Development course.

To-do lists frequently get out of hand, collecting items that aren't particularly important and thus get pushed off. Blocitoff was developed to help you stay focused on only the most important tasks. To do this, the application deletes items not completed after seven days.

Sign in/authentication was developed using the [devise](https://github.com/plataformatec/devise) gem, and updated as needed.

Items are added and removed easily:

![add/remove items](/app/assets/images/blocitoff-add-remove-items.gif)

The delete functionality was developed using the destroy action and jQuerey's hide() function to avoid page loads whenever an item is removed:

View ( _item.html.erb partial ):

```html
<tr id='item-<%= item.id %>'>
<td><%= item.name %></td>
<td><%= distance_of_time_in_words(Time.now, item.created_at + 7.days) %></td>
<td><%= link_to "", item, method: :delete, class: 'glyphicon glyphicon-ok', remote: true %></td>
</tr>
```

Controller:

```
def destroy
  @item = current_user.items.find(params[:id])
  
  if @item.destroy
    flash[:notice] = "Item was deleted successfully."
  else
    flash[:alert] = "There was an error deleting the item."
  end
  
  respond_to do |format|
    format.html
    format.js
  end
end
```

jQuerey Function:

```javascript
$('#item-<%= @item.id %>').hide();
```

Expired items (i.e. those created more than seven days ago) are deleted using a Rake task:

```ruby
namespace :todo do
  desc "Deletes items older than 7 days"
  task delete_items: :environment do
    Item.delete_expired
  end
end
```

The `delete_expired` function in the rake task is created in the model `item.rb`:

```ruby
def self.delete_expired
  where("created_at <= ?", Time.now - LIFETIME_IN_SECONDS).destroy_all
end
```


