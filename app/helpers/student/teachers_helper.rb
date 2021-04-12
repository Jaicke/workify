module Student::TeachersHelper
  def teacher_card_button_type(teacher_id)
    connection = current_user.connection_with(teacher_id)
    if connection.present?
      if connection.accepted?
        button_tag('Conectado', class: 'btn-connection connected', disabled: true)
      elsif connection.pending?
        button_tag('Pendente', class: 'btn-connection pending', disabled: true)
      end
    else
      button_tag("Conectar", class: "btn-connection connect", data: { id: teacher_id })
    end
  end
end
