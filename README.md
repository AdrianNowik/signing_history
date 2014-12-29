signing_history
===============

Signing history made as --full engine

You need to do few steps in Your main application, to make this feature
work.

First of all there are two branches, one for Devise and one for Sorcery.

1. When using Devise:

Add "gem 'signing_history', github: 'AdrianNowik/signing_history', branch: 'for_devise'" to Your gemfile.

Remember to run 'bundle' after changing gemfile.

Next step is installing migrations, by using 'rake railties:install:migrations', and run 'rake db:migrate'.

In Devise there is possibility to override default devise controllers,
we will override sessions controller, open config/routes.rb file and add this line:
devise_for :users, controllers: {sessions: 'signings'}

If You are already overriding sessions controller, name of overriding
controller should be named SessionsController.

When you are using this feature you have check signings history list at
admin_signing_in_histories_path. There is default view made in smart
admin, but You can override this by adding
app/views/admin/signings_in_histories/index view.


