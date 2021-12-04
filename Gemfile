# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

ruby '2.7.4'

group :test do
  gem "pry-byebug"
  gem "rspec"
end

group :development do
  gem 'rubocop', '~> 1.23', require: false
end
