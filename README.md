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
devise_for :users, controllers: {sessions: 'sessions'}

class SessionsController < Devise::SessionsController

  def create
    begin
      super
    ensure
      CreateSigningInHistory.new(params[:user][:email], request, user_signed_in?).process
    end
  end

end

The most important thing is this line CreateSigningInHistory.new(params[:user][:email], request, user_signed_in?).process, first argument is our login param, in this example it is email, but you need to change it if You have something different, You shouldnt change two other arguments.

When you are using this feature you have check signings history list at
admin_signing_in_histories_path. There is default view made in smart
admin, but You can override this by adding
app/views/admin/signings_in_histories/index view.

2. When using Sorcery:

Add "gem 'signing_history', github: 'AdrianNowik/signing_history', branch: 'for_sorcery'" to Your gemfile.

Remember to run 'bundle' after changing gemfile.

Next step is installing migrations, by using 'rake railties:install:migrations', and run 'rake db:migrate'.

In sorcery you just need to add to Your sessions create action: CreateSigningInHistory.new(params[:user][:email], request, user_signed_in?).proces after whole code in that action.
