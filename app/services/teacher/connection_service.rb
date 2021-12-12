class Teacher::ConnectionService
  def initialize(connection)
    @connection = connection
  end

  def accept!
    accept_connection
  end

  def decline!
    decline_connection
  end

  def self.accept!(connection)
    new(connection).accept!
  end


  def self.decline!(connection)
    new(connection).decline!
  end

  private

  def accept_connection
    @connection.accepted!
    create_notification(:accepted)
    Student::UserMailer.with(connection: @connection).connection_accepted_email.deliver_later
  end

  def decline_connection
    @connection.declined!
    create_notification(:declined)
    Student::UserMailer.with(connection: @connection).connection_declined_email.deliver_later
  end

  def create_notification(action)
    NotificationService.create!(@connection.teacher, @connection.student, action, @connection)
  end
end
