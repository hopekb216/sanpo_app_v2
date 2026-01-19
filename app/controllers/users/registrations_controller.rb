class Users::RegistrationsController < Devise::RegistrationsController
  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)

    if resource.update_with_password(account_update_params)
      flash[:notice] = "プロフィールを更新しました"
      redirect_to mypage_path
    else
      flash[:error] = resource.errors.full_messages
      redirect_to edit_user_registration_path
    end
  end
end

