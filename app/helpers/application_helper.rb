module ApplicationHelper
  def authorized_any?(array)
    array.each do |item|
      return true if authorized_show?(item)
    end
    false
  end

  def authorized_show?(object)
    object.user_id == current_user.id || current_user.admin?
  end

  def authorized_edit?(object)
    return true if current_user.admin? || current_user.id == object.user_id
    permission = Permission.find_by(user_id: current_user.id, permission_id: object.id)
    permission.present? && permission.full_access?
  end
end
