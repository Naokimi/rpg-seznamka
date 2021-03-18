# RPG Seznamka
Find a tabletop RPG group near you

### Prerequisites

- Ruby 2.7.2
- gem rails (we are using version 6.1.3)
- gem bundler

I recommend following [LeWagon's setup](https://github.com/lewagon/setup) to get your environment ready, but you'll probably have to install the required ruby version with rbenv

### Set up

Start in your folder with dev projects

- `gh repo clone Naokimi/rpg-seznamka`
- `cd rpg-seznamka`
- `bundle install`
- `yarn install`
- `rails db:create db:migrate db:seed`

### Running

Start in the project folder

- `rails s`

### Development process

Start in the project folder

- make sure you are on master branch and the working directory is clean (`git st` returns empty)
    - If it lists red files with a letter run `git stash`. If it lists red files with question marks remove the files `rm path/to/file`
- `git pull origin master`
- check the changes in files (Changed file -> run command):
    - Bundler -> `bundle install`
    - package-lock.json -> `yarn install`
    - db/schema.rb (and new files in db/migrate/) -> `rails db:migrate`
    - db/seeds.rb -> `rails db:seed`
- checkout to new branch `git checkout branch_name`
- work on the code
- implement tests covering your code
- add changes `git add path/to/file`
- commit changes `git commit -m "message describing the change"`
- check each item on the PRE-PUSH CHECKLIST below
- push `git push origin branch_name` or `git push origin HEAD`
- go to GitHub, open a PR, and add a short description of what the PR is trying to solve (by default follow the Issue-Solution model)
- tag [Naokimi](https://github.com/Naokimi) for the PR review

### PRE-PUSH CHECKLIST

**You are responsible for pushing working code**! The PR review serves only for feedback on styling or to suggest other solutions. This checklist is to help you check that you haven't accidentally created an issue elsewhere.

- make sure you aren't on master branch (if you are, this is the time to checkout!)
- run `rspec` to make sure there are no failing tests
- make sure there are no rubocop offenses
    - to check if rubocop works add `xY = hello` to any controller. If you don't see any yellow dots with notifications, then you need to install [rubocop](https://github.com/rubocop/rubocop) and restart your editor.
- if you've added a migration run `rails db:migrate` to check that there are no errors. Don't drop the table and don't delete migrations!
- if you've worked on a Model, run `rails db:seed` to make sure everything still saves.
- remove any commented lines that don't serve as explanation or reminder
- if you've had to make any changes due to the checklist, go back to the "work on code" point and follow each step from there

### Special thanks
Rails app generated with [lewagon/rails-templates](https://github.com/lewagon/rails-templates), created by the [Le Wagon coding bootcamp](https://www.lewagon.com) team.
