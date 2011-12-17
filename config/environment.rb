if ENV['RAILS_ENV'] == 'production'  # don't bother on dev
  ENV['GEM_PATH'] = '~/.rvm/gems/ruby-1.9.2-p290/gems/'
end