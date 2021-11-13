module Student::DiscussionsHelper
  def options_for_tag_select(discussion)
    container = []
    default_tags = ['Tema', 'Melhoria']

    default_tags.each do |default_tag|
      container.concat([default_tag]) unless discussion.tags.include?(default_tag)
    end

    discussion.tags.each do |tag|
      container.concat([tag])
    end

    container
  end
end
