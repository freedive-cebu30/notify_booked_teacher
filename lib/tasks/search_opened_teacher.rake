require 'capybara/poltergeist'
DMM_HOST = 'eikaiwa.dmm.com'
RAREJOB_HOST = 'www.rarejob.com'

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
        target = ">予約可</a>"
        session.visit "http://#{DMM_HOST}/teacher/index/#{teacher.online_teacher_id}/"
        opend_teacher = session.html.include?(target)
        params = { lesson_number: session.html.scan(target).size } if opend_teacher
        params[:service_name] = 'dmm'
      when 'rarejob'
        target = "reserveBtn"
        session.visit "http://#{RAREJOB_HOST}/teacher_detail/#{teacher.online_teacher_id}/"
        opend_teacher = session.html.include?(target)
        params = { lesson_number: session.html.scan(target).size } if opend_teacher
        params[:service_name] = 'rarejob'
      end
        if opend_teacher
          teacher.users.each do |user|
            UserMailer.notify_teacher(teacher, user, params).deliver_now
          end
        end
    end
  end
end