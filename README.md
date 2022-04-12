# Devise_Invitable with a previous Devise-JWT project

A Ruby on Rails API using Devise-JWT to login/register, and with devise_invitable to send an invitation to an email so that the user can add his/her password.

### Before starting

I recommend you to follow first 2 link tutorials recommended bellow in the links to understand this project.

### Prerequisites

Before starting you need some background on Ruby and Rails. Check the links bellow.

You need a working environment with Ruby on Rails installed and PostgreSQL as well.

### Before starting. API-only vs Server rendering

As you are using devise-jwt and not just devise you have to think about an api-only App. That's why ApplicationController extends ActionController::API, and most of the controllers extend ApplicationController, so that they all behaves as API-only returning JSON.

```
class ApplicationController < ActionController::API
end
```

But for the AcceptController we need to render a page so that the user who receives the gmail invitation can change the password from a server-rendered page. That's why in this case is necessary to extend from ActionController::Base as you can see:

```
class AcceptController < ActionController::Base

    def accept
        @invitation_token = params[:invitation_token]
        render "/accept"
    end 
end
```

### Installing

Open a command line console and clone this project.

```
git clone https://github.com/tcrurav/DeviseInvitableExample
```

Go to the new created directory

```
cd DeviseInvitableExample
```

Install all dependencies

```
bundle install
```

Now generate a secret key. And note the output. We’ll add this into our credentials file momentarily.

```
rake secret
```

Generate rails credentials. The commands below will create the config/master.key and config/credentials.yml.enc files:

```
EDITOR=nano rails credentials:edit
```

The notepad will open up. Now paste in the following, with the key generated from running rake secret above.

```
devise:
  jwt_secret_key: <rake secret key>
```

edit or create a config/application.yml file:

```
root_url: "http://localhost:3000"
mailer_email_email: "yourAccount@gmail.com"
mailer_email_password: "YourGmailPassword"

db_database: "invitable_development"
db_username: "postgres"
db_password: "YourPostgresPassword"
db_host: "localhost"
db_port: "5432"

db_database_test: "invitable_test"
db_username_test: "postgres"
db_password_test: "YourPostgresPassword"
db_host_test: "localhost"
db_port_test: "5432"
```

Now make all migrations:

```
rails db:create db:migrate
```

Boot your API

```
rails s
```

Before continuing take a time to configure your Gmail account to put it on an unsecure way but in a way to see the invitation in your inbox. Do it going to "setting for less secure apps".

![Create Project](/screenshots/screenshot-02.png)

Now it's time to enjoy this project. Test your API with POSTMAN using the following requests:
https://documenter.getpostman.com/view/3446841/UVeNkMk2


The recommended order for the POSTMAN requests will be:

```
POST http://localhost:3000/invite
```

You'll get a message saying 'You are not logged in'.

Now register a user and log in:

```
Post http://localhost:3000/users
POST http://localhost:3000/users/sign_in
```

Copy the Bearer Token in the headers returned, and use it in the following request:

```
POST http://localhost:3000/invite
```

Now you'll get a message in your Gmail inbox. Congrats!!!

![Create Project](/screenshots/screenshot-01.png)

If you click on "Accept Invitation" you will be able to enter a password:

![Create Project](/screenshots/screenshot-03.png)

After clicking on "Change Password" you are done. Your invitation has been accepted by the user who has changed his password. Congrats!!!

Now you can test your new user/password credentials with the following Postman request:

```
POST http://localhost:3000/users/sign_in
```

Enjoy!!!

## Built With

* [Rails](https://rubyonrails.org/) - Rails is a full-stack framework. It ships with all the tools needed to build amazing web apps on both the front and back end
* [devise-jwt](https://rubygems.org/gems/devise-jwt/versions/0.5.6?locale=es) - JWT authentication for devise with configurable token revocation strategies.
* [devise_invitable](https://github.com/scambra/devise_invitable) - It adds support to Devise for sending invitations by email (it requires to be authenticated) and accept the invitation setting the password.
* [PostgreSQL](https://www.postgresql.org/) - The World's Most Advanced Open Source Relational Database


## Acknowledgments

* https://medium.com/ruby-daily/a-devise-jwt-tutorial-for-authenticating-users-in-ruby-on-rails-ca214898318e. A Devise-JWT Tutorial For Authenticating Users in Ruby on Rails.
* https://dev.to/lisahjung/beginner-s-guide-to-creating-an-api-from-scratch-using-rails-2eie. Beginner's guide to creating an API from scratch using Rails.
* https://www.youtube.com/watch?v=5HMWE8g6_tc. Very interesting tutorial to understand the way devise_invitable works.
* https://guides.rubyonrails.org/v5.0/getting_started.html. Getting Started with Rails.
* https://stackoverflow.com/questions/57402435/how-to-run-rails-credentialsedit-on-windows-10-without-installing-a-linux-sub. How to run 'rails credentials:edit' on Windows 10.
* https://gist.github.com/db0sch/19c321cbc727917bc0e12849a7565af9. Regenerate Rails credentials.
