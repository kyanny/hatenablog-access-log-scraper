require 'capybara'
require 'capybara/dsl'
require 'capybara/poltergeist'
require 'tmpdir'

include Capybara::DSL

Capybara.default_driver = :poltergeist
# Capybara.default_driver = :selenium
Capybara.app_host = 'http://blog.hatena.ne.jp/'

visit "/#{ENV.fetch('HATENA_ID')}/#{ENV.fetch('BLOG_DOMAIN')}/accesslog"
fill_in 'name', with: ENV.fetch('HATENA_ID')
fill_in 'password', with: ENV.fetch('PASSWORD')
first('.submit-button').click
loop until has_css?('#access-counts-tabs')

Dir.chdir(Dir.tmpdir) do
  file = "ss-#{Time.now.to_i}.png"
  save_screenshot(file, selector: '#access-counts-tabs')
  puts "Save screenshot to #{Dir.pwd}/#{file}"
end
