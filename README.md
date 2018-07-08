# RoR learning experiment

This is a simple Ruby on Rails app for learning purpose.

#### Features

- User
    - Auth
	- Edition
	- Deletion
	
- Post
	- Listing
	- Creation
	- Edition
	- Deletion
	
- Comment
    - Listing
    - Creation
    - Deletion

#### Setup

Download of clone the repo
```shell
git clone https://github.com/NicolasMica/RoR-blog.git demo
```
 
Install the dependencies
```shell
cd demo
bundle install
```

Migrate & seed the database
```shell
rake db:migrate && rake db:seed
```

Start the server and navigate to [http://localhost:3000](http://localhost:3000)
```shell
rails server
```

#### Default user
A default user is created with the seeder, here are the credentials:

Email: **john.doe@example.com**
 
Password: **secret**
