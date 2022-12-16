module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    protected

    def find_verified_user
      if current_user = fetch_user
        current_user
      else
        reject_unauthorized_connection
      end
    end

    def fetch_user
      session = cookies.encrypted['_workify_session']

      return Student::User.find_by(id: session['student_user_id']) if session['student_user_id'].present?

      return Teacher::User.find_by(id: session['teacher_user_id']) if session['teacher_user_id'].present?
    end
  end
end
