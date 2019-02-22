# WP Template

## Prerequisites

- [nvm](https://github.com/creationix/nvm)
- [Composer](https://getcomposer.org/)
- The `php` commandline tool (this is installed _by default_ on OSX)
- A running mysql server. If you're using MAMP, you've already got one. If not, you can get the mysql server for OSX [here](https://dev.mysql.com/get/Downloads/MySQL-8.0/mysql-8.0.14-macos10.14-x86_64.dmg).

## Getting started

1. `nvm use`
2. `npm install`
3. `npm run dev`
4. `npm run dbrestore`

---

On your first run, a configuration wizard will ask some questions to set up your
local environment.

The site should now be up and running at http://localhost:9090. The
CMS can be reached at http://localhost:9090/wp-admin/. The default credentials
are `admin / cocacola99`.
