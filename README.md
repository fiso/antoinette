# WP Template

## Prerequisites

- [nvm](https://github.com/creationix/nvm)
- [Composer](https://getcomposer.org/)
- The `php` commandline tool (this is installed _by default_ on OSX)
- A running mysql server. You can get the mysql server for OSX [here](https://dev.mysql.com/get/Downloads/MySQL-8.0/mysql-8.0.14-macos10.14-x86_64.dmg).

## Starting a new project

1. `nvm install && nvm use`
2. `npm install`
3. `./scripts/start-new-project.sh [project-slug] [destination-folder]`

## Running an existing project

1. `nvm install && nvm use`
2. `npm install`
3. `npm run dev`

The site should now be up and running at [http://localhost:9090](http://localhost:9090). The CMS can be reached at [http://localhost:9090/wp-admin/](http://localhost:9090/wp-admin/). The default credentials are `admin / cocacola99`.
