class Admin::StaffMembersController < Admin::Base

  def index
    @staff_members = StaffMember.order(:family_name_kana, :given_name_kana)
    @staff_members = @staff_members.page(params[:page])
  end

  def show
    staff_member = StaffMember.find(params[:id])
    redirect_to [:edit, :admim, staff_member]
  end

  def new
    @staff_member = StaffMember.new
  end

  def edit
    @staff_member = StaffMember.find(params[:id])
  end

  def create
    @staff_member = StaffMember.new(staff_member_params)
    if @staff_member.save
      flash.notice = "職員アカウントを新規登録しました。"
      redirect_to :admin_staff_members
    else
      render action: "new"
    end
  end

  def update
    @staff_member = StaffMember.find(params[:id])
    @staff_member.assign_attributes(staff_member_params) # 実際の更新処理
    if @staff_member.save
      flash.notice = "職員アカウントを更新しました。"
      redirect_to :admin_staff_members
    else
      render action :"edit"
    end
  end

  def destroy
    staff_member = StaffMember.find(params[:id])
    staff_member.destroy!
    flash.alert = "職員アカウントを削除しました。"
    redirect_to :admin_staff_members
  end

  private
    def staff_member_params
      params.require(:staff_member).permit(:email, :password, :family_name, :given_name,
                                          :family_name_kana, :given_name_kana, :start_date,
                                          :end_date, :suspected)
    end
end
