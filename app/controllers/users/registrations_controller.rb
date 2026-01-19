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

  public

  # Turbo 対応の create
  def create
    build_resource(sign_up_params)

    resource.save
    yield resource if block_given?

    if resource.persisted?
      if resource.active_for_authentication?
        sign_up(resource_name, resource)
        respond_to do |format|
          format.turbo_stream { redirect_to root_path }
          format.html { redirect_to root_path }
        end
      else
        expire_data_after_sign_in!
        respond_to do |format|
          format.turbo_stream { redirect_to root_path }
          format.html { redirect_to root_path }
        end
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_to do |format|
        format.turbo_stream { render :new, status: :unprocessable_entity }
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # プロフィール更新処理
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
