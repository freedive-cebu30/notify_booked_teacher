module Eikaiwa
  class Crawler
    DMM_HOST = 'eikaiwa.dmm.com'
    RAREJOB_HOST = 'www.rarejob.com'
    SANKEI_HOST = 'learning.sankei.co.jp'

      def initialize(session)
        @session = session
      end

      def run_dmm(teacher)
        dmm_lp = "http://#{DMM_HOST}/teacher/index/#{teacher.online_teacher_id}/"
        m_dmm_lp = "http://#{DMM_HOST}/teacher/schedule/#{teacher.online_teacher_id}/"
        @session.visit dmm_lp
        target = '>予約可</a>'
        opend_teacher = @session.html.include?(target)
        if opend_teacher
            params = { lesson_number: @session.html.scan(target).size }
            params[:service_name] = 'dmm'
            params[:landing_page] = dmm_lp
            params[:m_landing_page] = m_dmm_lp
        end

        return [opend_teacher, params]
      end

      def run_rarejob(teacher)
          rarejob_lp = "http://#{RAREJOB_HOST}/teacher_detail/#{teacher.online_teacher_id}/"
          @session.visit rarejob_lp
          target = 'reserveBtn'
          opend_teacher = @session.html.include?(target)
          if opend_teacher
            params = { lesson_number: @session.html.scan(target).size }
            params[:service_name] = 'rarejob'
            params[:landing_page] = rarejob_lp
          end

        return [opend_teacher, params]
      end

      def run_sankei(teacher)
          sankei_lp = "http://#{SANKEI_HOST}/profile/#{teacher.online_teacher_id}/"
          @session.visit sankei_lp
          target = 'open_button'
          opend_teacher = @session.html.include?(target)
          if opend_teacher
            params = { lesson_number: @session.html.scan(target).size }
            params[:service_name] = 'sankei'
            params[:landing_page] = sankei_lp
          end

        return [opend_teacher, params]
      end

  end
end