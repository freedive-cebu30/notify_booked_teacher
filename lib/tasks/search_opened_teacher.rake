require 'capybara/poltergeist'

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
      opend_teacher, params =
        case teacher.service_name
        when 'dmm'
          Eikaiwa::Crawler.run_dmm(teacher)
        when 'rarejob'
          Eikaiwa::Crawler.run_rarejob(teacher)
        when 'sankei'
          Eikaiwa::Crawler.run_sankei(teacher)
        end

      if opend_teacher
        teacher.users.each do |user|
          UserMailer.notify_teacher(teacher, user, params).deliver_now
        end
      end
    end
  end
end