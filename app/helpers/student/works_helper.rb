module Student::WorksHelper
  def work_status_badge(status)
    badges = {
      not_started: '<span class="badge badge-secondary">Não iniciado</span>',
      in_progress: '<span class="badge badge-info">Em progresso</span>',
      concluded: '<span class="badge badge-success">Concluído</span>'
    }

    badges[status.to_sym].html_safe
  end

  def can_access_work_action?(work)
    @current_user.id == work.created_by.id
  end
end
