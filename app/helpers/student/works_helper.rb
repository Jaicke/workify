module Student::WorksHelper
  def work_status_badge(status)
    badges = {
      waiting_advisor: '<span class="badge badge badge-secondary">Aguardando Orientador</span>',
      in_progress: '<span class="badge badge badge-info">Em progresso</span>',
      complete: '<span class="badge badge badge-success">Completo</span>'
    }

    badges[status.to_sym].html_safe
  end

  def can_access_work_action?(work)
    @current_user.id == work.created_by.id
  end
end
