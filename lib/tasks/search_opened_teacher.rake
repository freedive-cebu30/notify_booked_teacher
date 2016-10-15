require 'capybara/poltergeist'
HOST = 'eikaiwa.dmm.com'
namespace :search do
  desc 'seach opened teacher'
  task :opened_teacher => :environment do

    Capybara.register_driver :poltergeist do |app|
      Capybara::Poltergeist::Driver.new(app, {:js_errors => false, :timeout => 500 })
    end

    session = Capybara::Session.new(:poltergeist)

    session.driver.headers = {
        'User-Agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2564.97 Safari/537.36'
    }
    Teacher.all.each do |teacher|
      case teacher.service_name
      when 'dmm'
        session.visit "http://#{HOST}/teacher/index/#{teacher.id}/"
        opend_teacher = session.html.include?(">予約可</a>")
      when 'rarejob'
      end
        if opend_teacher
        else
        end
    end
  end
end