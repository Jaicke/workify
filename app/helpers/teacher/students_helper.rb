module Teacher::StudentsHelper
  def connection_button(student_id)
    connection = current_user.connection_with(student_id)
    if connection.present?
      if connection.accepted?
        content_tag :div, class: 'mt-3' do
          button_tag('Conectado', class: 'btn btn-primary btn-rounded', disabled: true)
        end
      elsif connection.pending?
        content_tag :div, class: 'connection-buttons' do
          concat(link_to "Aceitar", accept_teacher_connection_path(connection), class: 'btn btn-dark btn-rounded')
          concat(link_to "Recusar", decline_teacher_connection_path(connection), class: 'btn btn-outline-danger btn-rounded')
        end
      end
    end
  end
end
