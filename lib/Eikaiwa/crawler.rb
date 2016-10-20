module Eikaiwa
  module Crawler
    DMM_HOST = 'eikaiwa.dmm.com'
    RAREJOB_HOST = 'www.rarejob.com'
    SANKEI_HOST = 'learning.sankei.co.jp'

    class << self
      def run_dmm(teacher)
        session.visit "http://#{DMM_HOST}/teacher/index/#{teacher.online_teacher_id}/"
        target = '>予約可</a>'
        opend_teacher = session.html.include?(target)
        if opend_teacher
            params = { lesson_number: session.html.scan(target).size }
            params[:service_name] = 'dmm'
        end

        return [opend_teacher, params]
      end

      def run_rarejob(teacher)
          session.visit "http://#{RAREJOB_HOST}/teacher_detail/#{teacher.online_teacher_id}/"
          target = 'reserveBtn'
          opend_teacher = session.html.include?(target)
          if opend_teacher
            params = { lesson_number: session.html.scan(target).size }
            params[:service_name] = 'rarejob'
          end

        return [opend_teacher, params]
      end

      def run_sankei(teacher)
          session.visit "http://#{SANKEI_HOST}/profile/#{teacher.online_teacher_id}/"
          target = 'open_button'
          opend_teacher = session.html.include?(target)
          if opend_teacher
            params = { lesson_number: session.html.scan(target).size }
            params[:service_name] = 'sankei'
          end

        return [opend_teacher, params]
      end

    end
  end
end