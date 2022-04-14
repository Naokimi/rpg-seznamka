# frozen_string_literal: true

module Api
  class RepoUpdatesController < ActionController::API
    def create
      update_faker_gem
      commit_and_push_to_github
      push_to_production

      render json: {}
    end

    private

    def update_faker_gem
      system('bundle update faker --conservative')
    end

    def commit_and_push_to_github
      hash_and_head = `git ls-remote https://github.com/faker-ruby/faker HEAD`
      commit_hash = hash_and_head.split("\t").first
      system("git add . && gc -m 'Update Faker from commit #{commit_hash}'")
      system('ggpush')
    end

    def push_to_production
      system('git push heroku master')
      system('heroku run rails db:migrate')
    end
  end
end
