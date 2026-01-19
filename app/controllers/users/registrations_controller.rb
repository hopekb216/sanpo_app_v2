class Users::RegistrationsController < Devise::RegistrationsController
  protected

  # サインアップ後（メール認証なし）
  def after_sign_up_path_for(resource)
    root_path
  end

  # サインアップ後（メール認証ありの場合はこちらが呼ばれる）
  def after_inactive_sign_up_path_for(resource)
    root_path
  end

  # ログイン後の遷移先
  def after_sign_in_path_for(resource)
    root_path
  end

  # プロフィール更新処理（あなたの元コードをそのまま保持）
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
