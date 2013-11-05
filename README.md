# Smart Factory Ruby on Rails exercises

This set of exercises will lead you through building an app that allows a bicycle shop's employees to track orders for fulfilling custom bicycle orders.

## Exercise Set 6

Our scaffolding generated some tests. I’ve updated them to work with the new fields we added, and also switched them from using Rails fixtures over to Factory Girl.

### Add some model tests

Add tests to verify that some of the existing features of the models work. Refer to `test/models/brand_test.rb` for reference.

To run your tests, use:

    bundle exec rake test

You may find the [Rails Testing](http://guides.rubyonrails.org/testing.html) and [Factory Girl](https://github.com/thoughtbot/factory_girl/blob/master/GETTING_STARTED.md) guides useful.

### Add a test for a new feature

We’d like to make brands require a name — but don’t do it yet! We’re going to implement it using _test first programming._

* Run your tests and make sure they’re all passing.
* Write a test that asserts that name is a required field on brand. It isn’t (yet), so this test should fail!
* Run your tests to make sure that your new test fails as expected.
* Change your code to implement the new behavior.
* Run your tests again. They should pass!

----

## Development Setup

### Fork the project

Use the 'Fork' button on the upper right of the project's github page.

### Check out a local copy:

    $ git clone git@github.com:<your_github_username>/ruby-on-rails-exercises.git

### Install the dependencies

    $ cd ruby-on-rails-exercises
    $ bundle install

## Previous Exercises

### Exercise Set 1

### Add a gem

Before writing any code, we would like to make a configuration change. Most projects we see use the [Haml](http://haml.info/) templating language, rather than Rails' default ERB. So, let's configure the app to use Haml.

Add the following line to `Gemfile`:

    gem 'haml-rails'

Now type `rails s` to start the server. You'll get an error, because the gem you just added isn't installed yet. Tell bundler to install the missing gems:

    $ bundle install

### Generate a scaffold

Our initial requirements are simply to allow creating and listing orders with a few fields for each order:

 * `customer_name`
 * `customer_email`
 * `description`
 * `price`
 * `paid_for_on` (the date that the bike was paid for).

Since this sounds like standard CRUD, use rails' scaffold generator to create an `Order` model and UI. You used the scaffold generator already if you followed the pre-class install instructions. For a review of how it works, run

    $ rails g scaffold
    
from the command line of your project directory.

### Migrate the DB

Now that the generator has defined a table, it's time to set up the database:

    $ rake db:migrate

If your server isn't already running, start it:

    $ rails s

Point your web browser to `http://localhost:3000/orders`, and create a few orders.

### Improve the style

They're pretty hard to read in the listing, aren't they? We've put some simple CSS together that should help with that, and stuck it in `examples/orders.css.scss`. Put those rules in an appropriate place so that Rails knows about them, then modify the orders index view so that the new CSS rules get used.

(No worries if you aren't familiar with CSS! Just ask and we'll give you a few hints about what you need to do.)

### Add validation rules

The default UI for entering the date that the order was paid for doesn't allow the field to be left blank, which is necessary in case the customer hasn't paid yet. Change it to a text input, so that it can be left blank until the order is paid for.

As the app stands now, it's possible to create orders that are missing vital information. Let's fix that -- make the customer name, customer email, description, and price required.

### Exercise Set 2

1. If you try to load the root of the site, `http://localhost:3000/`, you just see the default Rails homepage. Replace that with a simple welcome screen, which we'll build upon later. Just have it say "Welcome to the Bike Shop Order Tracker" and link to the /orders page.
1. As we add more sections to the site, we'll want site navigation to allow users to get around. Go ahead and change the site layout so that every page links to the new homepage, as well as to the /orders page.
1. Time to make the homepage more useful. In addition to welcoming the user, alter the page so that it displays the number of orders that haven't been paid for yet.
1. Employees are complaining about having to click onto an order's `edit` page to set the paid-on date, and at having to type in the date since it's usually the same date that they're updating the record on. To make their lives easier, add a `Mark Paid` link next to any unpaid orders on the `/orders` listing. When the employee clicks the link and confirms that the order has been paid, the record should be updated accordingly.

### Exercise Set 3

### Add a field

The bike shop has decided that they'd like to start keeping track of when they finish assembling a bike. This will allow them to do useful things like generate a list of bikes that have been completed but not paid for.

First, we'll need to update the database by adding a column to store the new field. We'll do this by generating a migration. From the command line in your project:

`$ rails g migration AddCompletedDate`

That will create an empty migration in the `db/migrate` folder, with a name based on what you just entered in the generator. Open that file in your text editor and add the following line to create the column:

`add_column :orders, :completed_on, :datetime`

Now that we've written the instructions for creating the column, it's time to actually create it in the database. From the command line:

`$ rake db:migrate`

For more on migrations, see [the Migration guide](http://guides.rubyonrails.org/migrations.html).

### Allow the field to be saved to the database

Now the field is defined in the database, but we have no way to read or write it through the web. First, let's add it to the order form, which you may recall is located in `app/views/orders/_form.html.haml`. You can copy the input for the paid_on date and update the copy to refer to the new column.

At this point, we can submit a completion date to the server, but it won't be saved. Why not? Because it would be insecure for our controller to accept updates to any arbitrary field. (If you want to see the warning generated when we attempt to save an unauthorized field, submit your newly modified form and look for the "Unpermitted parameters" line in the server log.)

To let Rails know that it's OK to accept updates to the completed_on field, open up the Orders controller in your editor, and add the field to the list in the `order_params` method. For more on this topic, see [the ActionController guide](http://guides.rubyonrails.org/action_controller_overview.html#strong-parameters).

Next, let's display the completion date when the order detail page is displayed. That's handled by the `show` template.

Finally, let's show the completion date on the orders index, and sort the orders so that unfinished orders show up first.

### Additional Challenges

1. Since an order is always entered into the system before it's completed, it's not necessary to display the completion date when creating a new order. Can you modify the new and edit forms so that they share as much as possible, but have this difference? The ActionView guide [has a helpful section](http://guides.rubyonrails.org/layouts_and_rendering.html#using-partials).
1. The shop manager is concerned that employees may enter future dates in the completion field, before an order is actually finished. She would like to prevent that, by requiring that the completion date always be equal to or earlier than today's date. Add a validation to enforce that rule. By now you should have a good idea where to look for a reference on the available options.
1. Add a count of unfinished orders on the homepage, so that it's clear how much work needs to be done. We did a similar exercise last time -- if you completed that exercise and your solution included a scope on the model, try using a class method this time, and vice versa.
1. Employees would like to be able to just click a single link to mark an order completed, rather than editing the order and entering the current date. Note that this task is similar to the 'mark paid' button from the last exercise set.

## Exercise Set 4

Instead of using only a free-form description field, the bicycle shop wants to systematically track the brand of bicycle for each order. We'll add a new model for bicycle brands, then create an association between brands and orders.

### Create the Brand model

Use Rails scaffolding to create a new brand model. For now, all brands need is a "name" attribute.

Hint: if you don't remember how to generate a scaffold, you can always get help at the command line:

    rails g scaffold

Look over the files the scaffold generated. Familiarize yourself with what just got added to your project.

The scaffold generates a new controller and new views for managing brands, but there are no links to it in your UI. Add a link to brands in the page header.

Create a few brands to make sure things are working.

### Create the order-brand association

We want to make it so that each order has a brand, and each brand has many orders.

To the order model (in `order.rb`), add:

    belongs_to :brand

...and in the brand model (`brand.rb`), add:

    has_many :orders

Now you have an association, but something is missing! Try it out using the Rails console:

    $ rails c
    Loading development environment (Rails 4.0.0)
    2.0.0p247 :001 > Order.first.brand

You'll get an error message. What's wrong? You added an assocation to your code, but not yet in the database. The orders table needs a brand_id column to make things work. (However, the brands table should not have an order_id column. Why not?)

Generate a new AddBrandToOrder migration with the following line:

    add_column :orders, :brand_id, :reference
    
The "reference" type just becomes an integer in the database, but declaring it as a reference lets Rails know our true intention.

Now the rails console experiment above should work.

[More info about Rails Associations](http://guides.rubyonrails.org/association_basics.html)

### Update the order form

Order can now have brands, but there's no way to select one in the UI.

Edit the order form (`app/views/orders/_form.html.haml`) to add a new text field for brand. How does that work? Answer: badly. (But do try it and see what happens.)

What we really want is a select box, not a free-form text field. Read about the Rails [collection_select](http://api.rubyonrails.org/classes/ActionView/Helpers/FormOptionsHelper.html#method-i-collection_select) helper, and use that to create a select box with the names of the various available brands.

You'll need to update the controller so the brand actually gets saved. Hint: look at exercise 3.

### Update the order index

Add a column to the orders index and show pages so that you can see the brand of each order.

Some previously created orders may not have brands. Make sure that doesn't blow things up!

### Challenges

* Make the brand a required field for orders. Should you require `brand` or `brand_id` on orders? Google around and read the debate!
* Some brands may go out of business and stop accepting orders. Add a boolean `active` flag to the brand model, then change the UI so it only shows active brands when editing an order.
* Oops! That's not quite good enough: an existing order may use an inactive brand — but we want to preserve that. Change the UI so it shows only active brands for new orders, but _all_ brands for existing orders.

---

