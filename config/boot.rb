# -*- encoding : utf-8 -*-
ENV['RAILS_ENV'] ||= 'development'

require 'rubygems'

# Set up gems listed in the Gemfile.
ENV['BUNDLE_GEMFILE'] ||= File.expand_path("Gemfile")


require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])
