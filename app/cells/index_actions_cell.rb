class IndexActionsCell < Cell::ViewModel
  def show
    render
  end

  private

  def show_link
    link_to '', object_path, class: 'glyphicon glyphicon-eye-open'
  end

  def edit_link
    link_to '', send('edit_' + object_class_name + '_path', model), class: 'glyphicon glyphicon-pencil'
  end

  def delete_link
    link_to '', object_path, method: :delete, data: { confirm: 'Are you sure?' }, class: 'glyphicon glyphicon-trash'
  end

  def object_path
    send(object_class_name + '_path', model)
  end

  def object_class_name
    model.class.to_s.underscore
  end
end
