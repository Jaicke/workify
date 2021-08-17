module Student::ReviewsHelper
  def review_status_badge(status)
    badges = {
      closed: '<span class="badge badge badge-danger">Fechada</span>',
      open: '<span class="badge badge badge-success">Aberta</span>'
    }

    badges[status.to_sym].html_safe
  end
end
