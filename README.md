ActiveRecord-Lite
=================

A simple ORM in the same vein as ActiveRecord.

## Usage

The 'SQLObject' class behaves similarly to the 'ActiveRecord::Base' class.

### Basic API

* `::all` - Queries and returns all objects of this class.
* `::find` - Queries and returns a single object by the id primary key
* `#save` - Intelligently updates existing record or inserts new record.

### Custom Search

* `::where` - Dynamically builds and executes query that is built up from passed in parameters.
```
Cat.where(name: 'Breakfast')

# SELECT *
# FROM cats
# WHERE
#   name = 'Breakfast'
```
### Associations

ActiveRecord Lite has `has_many` and `belongs_to` macros. As with real ActiveRecord, it attempts to infer the primary key, foreign key, and class name arguments if none are provided. For example, if a cat object has the association `belongs_to(:owner)`, it will infer that the primary key is `id`, the foreign key is `owner_id`, and the class name is `Owner`. However, if you specify `belongs_to(:owner, :class_name => "Human")`, it will not infer that the class name is `Owner`. From this class name, it will infer that the table name is `humans`.

## `has_one_through`

Unfinished code for a `has_one_through` can be found in the `04_associatable2.rb` file.
