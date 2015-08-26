ActiveRecord-Lite
=================

A simple ORM in the same vein as ActiveRecord.

## Usage

The 'SQLObject' class behaves similarly to the 'ActiveRecord::Base' class. All Rails models should inherit from 'SQLObject'.

### Basic API

* `::all` - Queries and returns all objects of this class.
* `::find` - Queries and returns a single object by the id primary key
* `#save` - Intelligently updates existing record or inserts a new record.

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

* `::belongs_to` - Used to define a parent table relationship.

#### Cat model
```
  class Cat < SQLObject
    belongs_to :human, foreign_key: :owner_id

    finalize!
  end

  # query for cat with id 1
  cat = Cat.find(1)

  # get its human
  human_of_cat = cat.human

  # invoking cat.human will query the humans table where the id is 1
```

* `::has_many` - Used to define the relationship to a child table.
#### Human model
```
  class Human < SQLObject
    self.table_name = 'humans'

    has_many :cats, foreign_key: :owner_id
    belongs_to :house

    finalize!
  end

  # query for human with id 1
  human = Human.find(1)

  # get all the human's cats
  cats_of_human = human.cats

  # invoking human.cats will query the cats table where the owner_id of the cat is 1
```
* `::has_one_through` - Used to define a relationship to one other object through a join table
#### Cat model
```
  #this example depends on the Human model defined above
  class Cat
    has_one_through :home, :human, :house

    self.finalize!
  end

  # query for cat with id 1
  cat = Cat.find(1)

  # get the cat's home through its human
  home_of_cat = cat.home

  # invoking cat.home will query the houses table where for the cat's human's house
```
